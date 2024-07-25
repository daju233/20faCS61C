#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    
        node *rabbit = head;
        node *turtle = head;
        if(head!=NULL){
        rabbit = rabbit->next->next;
        turtle = turtle->next;
        }
    while(rabbit!=turtle){
        if(rabbit==NULL||rabbit->next==NULL){
            return 0;
        }
        rabbit = rabbit->next->next;
        turtle = turtle->next;
    }
    return 1;
}