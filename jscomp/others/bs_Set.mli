(* Copyright (C) 2017 Authors of BuckleScript
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)




type ('k,'id) t 
val empty: dict:('elt, 'id) Bs_Cmp.t -> ('elt, 'id) t
val singleton: 'elt -> dict:('elt,'id) Bs_Cmp.t -> ('elt, 'id) t
(** [singleton x] returns the one-element set containing only [x]. *)    
val ofArray: dict:('k, 'id) Bs_Cmp.t -> 'k array -> ('k, 'id) t
val ofSortedArrayUnsafe: 'elt array -> dict:('elt, 'id) Bs_Cmp.t -> ('elt,'id) t
    
val isEmpty: _ t -> bool
val mem: ('elt, 'id) t -> 'elt ->  bool


val add:   
  ('elt, 'id) t -> 'elt -> ('elt, 'id) t
(** [add s x] If [x] was already in [s], [s] is returned unchanged. *)
val addArray: ('elt, 'id) t -> 'elt array -> ('elt, 'id) t 

val remove: ('elt, 'id) t -> 'elt -> ('elt, 'id) t
(** [remove m x] If [x] was not in [m], [m] is returned reference unchanged. *)

val removeArray:
  ('elt, 'id) t -> 'elt array -> ('elt, 'id) t 


val union: ('elt, 'id) t -> ('elt, 'id) t -> ('elt, 'id) t
val inter: ('elt, 'id) t -> ('elt, 'id) t -> ('elt, 'id) t 
val diff: ('elt, 'id) t -> ('elt, 'id) t -> ('elt, 'id) t
val subset: ('elt, 'id) t -> ('elt, 'id) t -> bool     

val cmp: ('elt, 'id) t -> ('elt, 'id) t -> int
(** Total ordering between sets. Can be used as the ordering function
    for doing sets of sets. *)
val eq: ('elt, 'id) t -> ('elt, 'id) t -> bool

val iter: ('elt, 'id) t -> ('elt -> unit [@bs]) ->  unit
(** [iter s f] applies [f] in turn to all elements of [s].
    In increasing order *)
val fold: ('elt, 'id) t -> 'a  -> ('a -> 'elt -> 'a [@bs]) ->  'a
(** In increasing order. *)
val forAll: ('elt, 'id) t -> ('elt -> bool [@bs]) -> bool
(** [for_all p s] checks if all elements of the set
    satisfy the predicate [p]. Order unspecified *)

val exists: ('elt, 'id) t ->  ('elt -> bool [@bs]) -> bool
(** [exists p s] checks if at least one element of
    the set satisfies the predicate [p]. *)
val filter: ('elt, 'id) t ->  ('elt -> bool [@bs]) -> ('elt, 'id) t
(** [filter m p] returns the set of all elements in [s]
    that satisfy predicate [p]. *)    
val partition: ('elt, 'id) t -> ('elt -> bool [@bs]) ->  ('elt, 'id) t * ('elt, 'id) t
(** [partition m p] returns a pair of sets [(s1, s2)], where
    [s1] is the set of all the elements of [s] that satisfy the
    predicate [p], and [s2] is the set of all the elements of
    [s] that do not satisfy [p]. *)

val length:  ('elt, 'id) t -> int
val toList: ('elt, 'id) t -> 'elt list
(** In increasing order*)
val toArray: ('elt, 'id) t -> 'elt array

val minOpt: ('elt, 'id) t -> 'elt option
val minNull: ('elt, 'id) t -> 'elt Js.null
val maxOpt: ('elt, 'id) t -> 'elt option
val maxNull: ('elt, 'id) t -> 'elt Js.null



val findOpt: ('elt, 'id) t -> 'elt -> 'elt option 
val findNull: ('elt, 'id) t -> 'elt -> 'elt Js.null 

val split: ('elt, 'id) t -> 'elt -> (('elt, 'id) t  * ('elt, 'id) t) * bool
                                    
val checkInvariant: _ t -> bool

(****************************************************************************)
(** Below are operations only when better performance needed,
    it is still safe API but more verbose. *)
type ('k,'id) t0    
val getData: ('k,'id) t  -> ('k,'id) t0
val getDict: ('k,'id) t  -> ('k,'id) Bs_Cmp.t
val packDictData: dict:('k, 'id) Bs_Cmp.t -> data:('k, 'id) t0 -> ('k, 'id) t
    
val empty0: ('elt, 'id) t0
val ofArray0: cmp:('k,'id) Bs_Cmp.cmp -> 'k array -> ('k, 'id) t0  
val isEmpty0: ('elt, 'id) t0 -> bool
val mem0: 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> 'elt -> bool
val add0: 
  ('elt, 'id) t0 -> 
  'elt ->  
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0
val addArray0:  
  ('elt, 'id) t0 -> 'elt array ->
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0
val removeArray0:  
  ('elt, 'id) t0 -> 'elt array ->
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0

val singleton0: 'elt -> ('elt, 'id) t0
val remove0: 
  ('elt, 'id) t0 -> 
  'elt ->  
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0
val union0: 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> ('elt, 'id) t0 -> ('elt, 'id) t0
val inter0: 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> ('elt, 'id) t0 -> ('elt, 'id) t0
val diff0: 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> ('elt, 'id) t0 -> ('elt, 'id) t0


val subset0: 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> ('elt, 'id) t0 -> bool

val cmp0: 
  ('elt, 'id) t0 -> ('elt, 'id) t0  -> 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  int

val eq0:
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> ('elt, 'id) t0 -> bool

val iter0: ('elt, 'id) t0 -> ('elt -> unit [@bs]) ->  unit

val fold0: ('elt, 'id) t0 -> 'a -> ('a -> 'elt ->  'a [@bs]) ->  'a
val forAll0: ('elt, 'id) t0 -> ('elt -> bool [@bs]) ->  bool
val exists0: ('elt, 'id) t0 -> ('elt -> bool [@bs]) ->  bool

val filter0: ('elt, 'id) t0 -> ('elt -> bool [@bs]) ->  ('elt, 'id) t0

val partition0: ('elt, 'id) t0 -> ('elt -> bool [@bs]) -> ('elt, 'id) t0 * ('elt, 'id) t0

val length0: ('elt, 'id) t0 -> int

val toList0: ('elt, 'id) t0 -> 'elt list

val toArray0: ('elt, 'id) t0 -> 'elt array


val minOpt0: ('elt, 'id) t0 -> 'elt option

val maxOpt0: ('elt, 'id) t0 -> 'elt option



val split0: 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> 'elt -> 
  (('elt, 'id) t0  * ('elt, 'id) t0) * bool

val ofSortedArrayUnsafe0:
  'elt array -> ('elt,'id) t0
  

val findOpt0: 
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> 'elt -> 'elt option


val findNull0:
  cmp: ('elt,'id) Bs_Cmp.cmp ->
  ('elt, 'id) t0 -> 'elt -> 'elt Js.null
