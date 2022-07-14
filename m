Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98146575162
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 17:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiGNPFi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiGNPFh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 11:05:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE012080
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 08:05:35 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1B57934B34;
        Thu, 14 Jul 2022 15:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1657811133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDTC7I/7lJw5/GQMMLEFnt6FrqgELm4iKTIAotRQ9D0=;
        b=B2jDc+kjCMOyPTl12lLlj/t7bLU/RPXG4i8fbJu4TMoPbQ0Fgh0GwYA7Lvt/hDMVIK3u1S
        Pv21NN6Vufxrag4nhZGaS8gmZ+7xM7WyvI4Ap+DTCEkSoMzSbOb5+jLJj7LvejH/qj5irm
        MLk2zT77cMlxwgpM0N3+ytOjpMqFMvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1657811133;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDTC7I/7lJw5/GQMMLEFnt6FrqgELm4iKTIAotRQ9D0=;
        b=QKK7ux263qwDj8elscyF5yHtzJStR09yNbrIRTtFytOaNANbH7LYvIkKcng3XCFzXVliIR
        sPFUd0grTaHxBUAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 049E82C141;
        Thu, 14 Jul 2022 15:05:33 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AC1E4A0659; Thu, 14 Jul 2022 17:05:32 +0200 (CEST)
Date:   Thu, 14 Jul 2022 17:05:32 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 10/10] mbcache: Automatically delete entries from cache
 on freeing
Message-ID: <20220714150532.wndjlbozlnhniofo@quack3>
References: <20220712104519.29887-1-jack@suse.cz>
 <20220712105436.32204-10-jack@suse.cz>
 <20220714130951.2fc4tjrc53b6vzla@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714130951.2fc4tjrc53b6vzla@riteshh-domain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 14-07-22 18:39:51, Ritesh Harjani wrote:
> On 22/07/12 12:54PM, Jan Kara wrote:
> > Use the fact that entries with elevated refcount are not removed from
> 
> The elevated refcnt means >= 2?

Well, it means when there is real user of the mbcache entry. So 3 before
this patch, 2 after this patch...

> > the hash and just move removal of the entry from the hash to the entry
> > freeing time. When doing this we also change the generic code to hold
> > one reference to the cache entry, not two of them, which makes code
> > somewhat more obvious.
> >
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/mbcache.c            | 108 +++++++++++++++-------------------------
> >  include/linux/mbcache.h |  24 ++++++---
> >  2 files changed, 55 insertions(+), 77 deletions(-)
> >
> > diff --git a/fs/mbcache.c b/fs/mbcache.c
> > index d1ebb5df2856..96f1d49d30a5 100644
> > --- a/fs/mbcache.c
> > +++ b/fs/mbcache.c
> > @@ -90,7 +90,7 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
> >  		return -ENOMEM;
> >
> >  	INIT_LIST_HEAD(&entry->e_list);
> > -	/* One ref for hash, one ref returned */
> > +	/* Initial hash reference */
> >  	atomic_set(&entry->e_refcnt, 1);
> >  	entry->e_key = key;
> >  	entry->e_value = value;
> > @@ -106,21 +106,28 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
> >  		}
> >  	}
> >  	hlist_bl_add_head(&entry->e_hash_list, head);
> > -	hlist_bl_unlock(head);
> > -
> > +	/*
> > +	 * Add entry to LRU list before it can be found by
> > +	 * mb_cache_entry_delete() to avoid races
> > +	 */
> 
> No reference to mb_cache_entry_delete() now. It is
> mb_cache_entry_delete_or_get()

Thanks, will fix.

> >  	spin_lock(&cache->c_list_lock);
> >  	list_add_tail(&entry->e_list, &cache->c_list);
> > -	/* Grab ref for LRU list */
> > -	atomic_inc(&entry->e_refcnt);
> >  	cache->c_entry_count++;
> >  	spin_unlock(&cache->c_list_lock);
> > +	hlist_bl_unlock(head);
> >
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(mb_cache_entry_create);
> >
> > -void __mb_cache_entry_free(struct mb_cache_entry *entry)
> > +void __mb_cache_entry_free(struct mb_cache *cache, struct mb_cache_entry *entry)
> >  {
> > +	struct hlist_bl_head *head;
> > +
> > +	head = mb_cache_entry_head(cache, entry->e_key);
> > +	hlist_bl_lock(head);
> > +	hlist_bl_del(&entry->e_hash_list);
> > +	hlist_bl_unlock(head);
> >  	kmem_cache_free(mb_entry_cache, entry);
> >  }
> >  EXPORT_SYMBOL(__mb_cache_entry_free);
> > @@ -134,7 +141,7 @@ EXPORT_SYMBOL(__mb_cache_entry_free);
> >   */
> >  void mb_cache_entry_wait_unused(struct mb_cache_entry *entry)
> >  {
> > -	wait_var_event(&entry->e_refcnt, atomic_read(&entry->e_refcnt) <= 3);
> > +	wait_var_event(&entry->e_refcnt, atomic_read(&entry->e_refcnt) <= 2);
> >  }
> >  EXPORT_SYMBOL(mb_cache_entry_wait_unused);
> >
> > @@ -155,10 +162,9 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
> >  	while (node) {
> >  		entry = hlist_bl_entry(node, struct mb_cache_entry,
> >  				       e_hash_list);
> > -		if (entry->e_key == key && entry->e_reusable) {
> > -			atomic_inc(&entry->e_refcnt);
> > +		if (entry->e_key == key && entry->e_reusable &&
> > +		    atomic_inc_not_zero(&entry->e_refcnt))
> >  			goto out;
> > -		}
> >  		node = node->next;
> >  	}
> >  	entry = NULL;
> > @@ -218,10 +224,9 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
> >  	head = mb_cache_entry_head(cache, key);
> >  	hlist_bl_lock(head);
> >  	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
> > -		if (entry->e_key == key && entry->e_value == value) {
> > -			atomic_inc(&entry->e_refcnt);
> > +		if (entry->e_key == key && entry->e_value == value &&
> > +		    atomic_inc_not_zero(&entry->e_refcnt))
> >  			goto out;
> > -		}
> >  	}
> >  	entry = NULL;
> >  out:
> > @@ -244,37 +249,25 @@ EXPORT_SYMBOL(mb_cache_entry_get);
> >  struct mb_cache_entry *mb_cache_entry_delete_or_get(struct mb_cache *cache,
> >  						    u32 key, u64 value)
> >  {
> > -	struct hlist_bl_node *node;
> > -	struct hlist_bl_head *head;
> >  	struct mb_cache_entry *entry;
> >
> > -	head = mb_cache_entry_head(cache, key);
> > -	hlist_bl_lock(head);
> > -	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
> > -		if (entry->e_key == key && entry->e_value == value) {
> > -			if (atomic_read(&entry->e_refcnt) > 2) {
> > -				atomic_inc(&entry->e_refcnt);
> > -				hlist_bl_unlock(head);
> > -				return entry;
> > -			}
> > -			/* We keep hash list reference to keep entry alive */
> > -			hlist_bl_del_init(&entry->e_hash_list);
> > -			hlist_bl_unlock(head);
> > -			spin_lock(&cache->c_list_lock);
> > -			if (!list_empty(&entry->e_list)) {
> > -				list_del_init(&entry->e_list);
> > -				if (!WARN_ONCE(cache->c_entry_count == 0,
> > -		"mbcache: attempt to decrement c_entry_count past zero"))
> > -					cache->c_entry_count--;
> > -				atomic_dec(&entry->e_refcnt);
> > -			}
> > -			spin_unlock(&cache->c_list_lock);
> > -			mb_cache_entry_put(cache, entry);
> > -			return NULL;
> > -		}
> > -	}
> > -	hlist_bl_unlock(head);
> > +	entry = mb_cache_entry_get(cache, key, value);
> > +	if (!entry)
> > +		return NULL;
> > +
> > +	/*
> > +	 * Drop the ref we got from mb_cache_entry_get() and the initial hash
> > +	 * ref if we are the last user
> > +	 */
> > +	if (atomic_cmpxchg(&entry->e_refcnt, 2, 0) != 2)
> > +		return entry;
> >
> > +	spin_lock(&cache->c_list_lock);
> > +	if (!list_empty(&entry->e_list))
> > +		list_del_init(&entry->e_list);
> > +	cache->c_entry_count--;
> > +	spin_unlock(&cache->c_list_lock);
> > +	__mb_cache_entry_free(cache, entry);
> >  	return NULL;
> >  }
> >  EXPORT_SYMBOL(mb_cache_entry_delete_or_get);
> > @@ -306,42 +299,24 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
> >  				     unsigned long nr_to_scan)
> >  {
> >  	struct mb_cache_entry *entry;
> > -	struct hlist_bl_head *head;
> >  	unsigned long shrunk = 0;
> >
> >  	spin_lock(&cache->c_list_lock);
> >  	while (nr_to_scan-- && !list_empty(&cache->c_list)) {
> >  		entry = list_first_entry(&cache->c_list,
> >  					 struct mb_cache_entry, e_list);
> > -		if (entry->e_referenced || atomic_read(&entry->e_refcnt) > 2) {
> > +		/* Drop initial hash reference if there is no user */
> > +		if (entry->e_referenced ||
> > +		    atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {
> 
> So here if the refcnt of an entry is 1. That means it is still in use right.

No. One reference is held by the hashtable/LRU itself. So 1 means entry is
free.

> So the shrinker will do the atomic_cmpxchg and make it to 0. And then
> delete the entry from the cache?
> This will only happen for entry with just 1 reference count.
> 
> Is that correct understanding?

Correct. Basically the atomic 1 -> 0 transition makes sure we are not
racing with anybody else doing the 1 -> 2 transition. And once reference
gets to 0, we make sure no new references can be created.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
