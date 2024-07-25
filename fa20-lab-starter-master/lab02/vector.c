/* Include the system headers we need */
#include <stdlib.h>
#include <stdio.h>

/* Include our header */
#include "vector.h"

/* Define what our struct is */
struct vector_t {
    size_t size;
    int *data;
};

/* Utility function to handle allocation failures. In this
   case we print a message and exit. */
static void allocation_failed() {
    fprintf(stderr, "Out of memory.\n");
    exit(1);
}

/* Bad example of how to create a new vector */
vector_t *bad_vector_new() {
    /* Create the vector and a pointer to it */
    vector_t *retval, v;
    retval = &v;
    /*
    内存泄漏：此函数中定义的vector_t v是在栈上创建的局部变量。
    当bad_vector_new()函数返回时，v将超出作用域并被销毁，但v的数据指针v.data指向的堆内存并没有被释放。
    因此，当retval指向v并返回给调用者后，v被销毁，retval->data成为悬空指针，指向的堆内存没有机会被释放，导致内存泄漏。

    返回栈上变量的地址：retval = &v;这一行代码返回的是v在栈上的地址。
    由于v是一个局部变量，当函数结束时，这个地址将变得无效。
    这意味着调用者接收的vector_t *指针最终会指向无效的内存位置，这将导致未定义行为，甚至程序崩溃。
    */

    /* Initialize attributes */
    retval->size = 1;
    retval->data = malloc(sizeof(int));
    if (retval->data == NULL) {
        allocation_failed();
    }

    retval->data[0] = 0;
    return retval;
}

/* Another suboptimal way of creating a vector */
vector_t also_bad_vector_new() {
    /* Create the vector */
    vector_t v;

    /* Initialize attributes */
    v.size = 1;
    v.data = malloc(sizeof(int));
    if (v.data == NULL) {
        allocation_failed();
    }
    v.data[0] = 0;
    return v;
}
/*
栈上对象的生命周期问题：此函数同样在栈上创建了vector_t v。当函数返回v时，v的数据成员v.data指向堆上分配的内存。
但是，v本身是一个栈对象，当also_bad_vector_new()函数返回时，v将被销毁，这意味着v.data的关联上下文丢失，而v.data指向的堆内存无法被跟踪或释放，同样导致内存泄漏。
复制问题???：返回vector_t结构体时，由于v包含一个指针v.data，这会导致浅复制(shallow copy)问题。
也就是说，返回的vector_t副本将与原v共享v.data指向的同一块堆内存。如果在函数外部修改了这个副本，也可能影响到原v的data，反之亦然，这可能导致数据一致性问题。
*/
/* Create a new vector with a size (length) of 1
   and set its single component to zero... the
   RIGHT WAY */
vector_t *vector_new() {
    vector_t *retval;
    retval = malloc(sizeof(vector_t));

    if (retval==NULL) {
        allocation_failed();
    }

    
    retval->size = 1;
    retval->data = malloc(sizeof(int));


    if (retval->data==NULL) {
        free(retval);		//Why is this line necessary?
        allocation_failed();
    }
    retval->data[0]= 0;

    return retval;
}

/* Return the value at the specified location/component "loc" of the vector */
int vector_get(vector_t *v, size_t loc) {

    /* If we are passed a NULL pointer for our vector, complain about it and exit. */
    if(v == NULL) {
        fprintf(stderr, "vector_get: passed a NULL vector.\n");
        abort();
    }

    /* If the requested location is higher than we have allocated, return 0.
     * Otherwise, return what is in the passed location.
     */
    if ((int)loc < v->size /* YOUR CODE HERE */) {
        return /* YOUR CODE HERE */v->data[loc];
    } else {
        return 0;
    }
}

/* Free up the memory allocated for the passed vector.
   Remember, you need to free up ALL the memory that was allocated. */
void vector_delete(vector_t *v) {
    if(v!=NULL&&v->data!=NULL){
        for(int i =0;i<v->size;i++){
            v->data[i]=0;
        }
        free(v->data);
        v->data=NULL;
        v->size=0;
        free(v);
        v=NULL;
    }
}

/* Set a value in the vector. If the extra memory allocation fails, call
   allocation_failed(). */
void vector_set(vector_t *v, size_t loc, int value) {
    /* What do you need to do if the location is greater than the size we have
     * allocated?  Remember that unset locations should contain a value of 0.
     */

    if(loc>=v->size){
        int i =0;
        int size = loc+1;
        int *temp = malloc(size*sizeof(int));


        for(i=0;i<size;i++){
            if(i<v->size)
            {
                temp[i]=v->data[i];
            }
            else{
                temp[i]=0;
            }
        }
        temp[loc]=value;
        free(v->data);
        v->data=temp;
        v->size=size;
        
    }else{
        v->data[loc]=value;
    }
    for (int i = 0; i <= loc; i++)
    {
        printf("%d ",v->data[i]);
    }
    printf("\n");
    
}
