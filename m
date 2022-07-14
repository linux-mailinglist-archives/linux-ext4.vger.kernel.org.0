Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36D574EB2
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 15:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiGNNJ7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbiGNNJ6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 09:09:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9890E2A40E
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 06:09:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v21so360542plo.0
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V6prAm6f/AR15pNL97Q/dQrdTW2DjhjAIoTDAX+66Ns=;
        b=eAGp+Sn6PRuj0bibg9kxCLCe4gmuKkZmZ5E+C4bL2tBEVgcMFeT/MsVjw5taZDim1O
         k0YjKwzKDzKjChMI2SwGis8MRUiHph1eok6SkZxLLRTfUIFwyTHchDGpSi7b+A3sPcHl
         8Gt3atfmAPABZpUqLVM5jwY9/H3hQWUL8aswa56ogfFosMQvm/iILnYSxMM0HHMUeO2/
         wITmMZ8r/P06cwbklMyp2oOkIZINo3r4HaO3UHN/0LeNMMp1v5kHNGjGtgpf/KKCmuim
         pewVvcB9FaNVEKBeA8yVvNMpEDMW5WDE8n14SC5GL9vu2z49bM6sgxZyCa+e1tMRR1hF
         U7mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V6prAm6f/AR15pNL97Q/dQrdTW2DjhjAIoTDAX+66Ns=;
        b=f4vxvrGcKXo/lWErqw2qsxUYkOk22n8gWsecoLGvB6xYLAwfL7s+v6J1VHjz9/AOo/
         uyZfnW4tBqJjHfxALs5mDivrXZmAcs99sP+e4JHCSV+cZJ9pckGfzxeyh3HbtN0IBHSE
         lp3sr1y5c01SHlb1R1PkGHOG+vkj8VSx7DTxlYv1FaF0nEm/bF30VC9YBpl4e+Y2FG87
         I9T0qmbLSVF/LvCIb7wd9zMjzRJILY6EPHTR8hckIo44dGd88pKiL3204nSZhw/I2iSF
         97+z2fsfMdM0n5JVk/cs+sHLCS4JSePRRbKx4Jl/0zCpsPqh52k3iEbKwaXcok++b6Di
         STQw==
X-Gm-Message-State: AJIora934fJM5fru9qcdLvIkMFQsezDhu8z+w4+eH/v3kIzFHdvPGyFJ
        xstbwatzrAb3hJtVLd9/gpM=
X-Google-Smtp-Source: AGRyM1sVLpjuDdyMFqtd4dXTqoymOiYTr4ANTVh0XA7cO3k8VWZITqYTFRVEyoH42p5lQUF/4zwGUw==
X-Received: by 2002:a17:902:eec2:b0:16c:9837:cd4 with SMTP id h2-20020a170902eec200b0016c98370cd4mr5831223plb.132.1657804197085;
        Thu, 14 Jul 2022 06:09:57 -0700 (PDT)
Received: from localhost ([2406:7400:63:cb1d:811:33e9:9bc2:d40])
        by smtp.gmail.com with ESMTPSA id w11-20020a62820b000000b005252433bdbdsm1645704pfd.95.2022.07.14.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 06:09:56 -0700 (PDT)
Date:   Thu, 14 Jul 2022 18:39:51 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 10/10] mbcache: Automatically delete entries from cache
 on freeing
Message-ID: <20220714130951.2fc4tjrc53b6vzla@riteshh-domain>
References: <20220712104519.29887-1-jack@suse.cz>
 <20220712105436.32204-10-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712105436.32204-10-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/07/12 12:54PM, Jan Kara wrote:
> Use the fact that entries with elevated refcount are not removed from

The elevated refcnt means >= 2?

> the hash and just move removal of the entry from the hash to the entry
> freeing time. When doing this we also change the generic code to hold
> one reference to the cache entry, not two of them, which makes code
> somewhat more obvious.
>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/mbcache.c            | 108 +++++++++++++++-------------------------
>  include/linux/mbcache.h |  24 ++++++---
>  2 files changed, 55 insertions(+), 77 deletions(-)
>
> diff --git a/fs/mbcache.c b/fs/mbcache.c
> index d1ebb5df2856..96f1d49d30a5 100644
> --- a/fs/mbcache.c
> +++ b/fs/mbcache.c
> @@ -90,7 +90,7 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
>  		return -ENOMEM;
>
>  	INIT_LIST_HEAD(&entry->e_list);
> -	/* One ref for hash, one ref returned */
> +	/* Initial hash reference */
>  	atomic_set(&entry->e_refcnt, 1);
>  	entry->e_key = key;
>  	entry->e_value = value;
> @@ -106,21 +106,28 @@ int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
>  		}
>  	}
>  	hlist_bl_add_head(&entry->e_hash_list, head);
> -	hlist_bl_unlock(head);
> -
> +	/*
> +	 * Add entry to LRU list before it can be found by
> +	 * mb_cache_entry_delete() to avoid races
> +	 */

No reference to mb_cache_entry_delete() now. It is
mb_cache_entry_delete_or_get()

>  	spin_lock(&cache->c_list_lock);
>  	list_add_tail(&entry->e_list, &cache->c_list);
> -	/* Grab ref for LRU list */
> -	atomic_inc(&entry->e_refcnt);
>  	cache->c_entry_count++;
>  	spin_unlock(&cache->c_list_lock);
> +	hlist_bl_unlock(head);
>
>  	return 0;
>  }
>  EXPORT_SYMBOL(mb_cache_entry_create);
>
> -void __mb_cache_entry_free(struct mb_cache_entry *entry)
> +void __mb_cache_entry_free(struct mb_cache *cache, struct mb_cache_entry *entry)
>  {
> +	struct hlist_bl_head *head;
> +
> +	head = mb_cache_entry_head(cache, entry->e_key);
> +	hlist_bl_lock(head);
> +	hlist_bl_del(&entry->e_hash_list);
> +	hlist_bl_unlock(head);
>  	kmem_cache_free(mb_entry_cache, entry);
>  }
>  EXPORT_SYMBOL(__mb_cache_entry_free);
> @@ -134,7 +141,7 @@ EXPORT_SYMBOL(__mb_cache_entry_free);
>   */
>  void mb_cache_entry_wait_unused(struct mb_cache_entry *entry)
>  {
> -	wait_var_event(&entry->e_refcnt, atomic_read(&entry->e_refcnt) <= 3);
> +	wait_var_event(&entry->e_refcnt, atomic_read(&entry->e_refcnt) <= 2);
>  }
>  EXPORT_SYMBOL(mb_cache_entry_wait_unused);
>
> @@ -155,10 +162,9 @@ static struct mb_cache_entry *__entry_find(struct mb_cache *cache,
>  	while (node) {
>  		entry = hlist_bl_entry(node, struct mb_cache_entry,
>  				       e_hash_list);
> -		if (entry->e_key == key && entry->e_reusable) {
> -			atomic_inc(&entry->e_refcnt);
> +		if (entry->e_key == key && entry->e_reusable &&
> +		    atomic_inc_not_zero(&entry->e_refcnt))
>  			goto out;
> -		}
>  		node = node->next;
>  	}
>  	entry = NULL;
> @@ -218,10 +224,9 @@ struct mb_cache_entry *mb_cache_entry_get(struct mb_cache *cache, u32 key,
>  	head = mb_cache_entry_head(cache, key);
>  	hlist_bl_lock(head);
>  	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
> -		if (entry->e_key == key && entry->e_value == value) {
> -			atomic_inc(&entry->e_refcnt);
> +		if (entry->e_key == key && entry->e_value == value &&
> +		    atomic_inc_not_zero(&entry->e_refcnt))
>  			goto out;
> -		}
>  	}
>  	entry = NULL;
>  out:
> @@ -244,37 +249,25 @@ EXPORT_SYMBOL(mb_cache_entry_get);
>  struct mb_cache_entry *mb_cache_entry_delete_or_get(struct mb_cache *cache,
>  						    u32 key, u64 value)
>  {
> -	struct hlist_bl_node *node;
> -	struct hlist_bl_head *head;
>  	struct mb_cache_entry *entry;
>
> -	head = mb_cache_entry_head(cache, key);
> -	hlist_bl_lock(head);
> -	hlist_bl_for_each_entry(entry, node, head, e_hash_list) {
> -		if (entry->e_key == key && entry->e_value == value) {
> -			if (atomic_read(&entry->e_refcnt) > 2) {
> -				atomic_inc(&entry->e_refcnt);
> -				hlist_bl_unlock(head);
> -				return entry;
> -			}
> -			/* We keep hash list reference to keep entry alive */
> -			hlist_bl_del_init(&entry->e_hash_list);
> -			hlist_bl_unlock(head);
> -			spin_lock(&cache->c_list_lock);
> -			if (!list_empty(&entry->e_list)) {
> -				list_del_init(&entry->e_list);
> -				if (!WARN_ONCE(cache->c_entry_count == 0,
> -		"mbcache: attempt to decrement c_entry_count past zero"))
> -					cache->c_entry_count--;
> -				atomic_dec(&entry->e_refcnt);
> -			}
> -			spin_unlock(&cache->c_list_lock);
> -			mb_cache_entry_put(cache, entry);
> -			return NULL;
> -		}
> -	}
> -	hlist_bl_unlock(head);
> +	entry = mb_cache_entry_get(cache, key, value);
> +	if (!entry)
> +		return NULL;
> +
> +	/*
> +	 * Drop the ref we got from mb_cache_entry_get() and the initial hash
> +	 * ref if we are the last user
> +	 */
> +	if (atomic_cmpxchg(&entry->e_refcnt, 2, 0) != 2)
> +		return entry;
>
> +	spin_lock(&cache->c_list_lock);
> +	if (!list_empty(&entry->e_list))
> +		list_del_init(&entry->e_list);
> +	cache->c_entry_count--;
> +	spin_unlock(&cache->c_list_lock);
> +	__mb_cache_entry_free(cache, entry);
>  	return NULL;
>  }
>  EXPORT_SYMBOL(mb_cache_entry_delete_or_get);
> @@ -306,42 +299,24 @@ static unsigned long mb_cache_shrink(struct mb_cache *cache,
>  				     unsigned long nr_to_scan)
>  {
>  	struct mb_cache_entry *entry;
> -	struct hlist_bl_head *head;
>  	unsigned long shrunk = 0;
>
>  	spin_lock(&cache->c_list_lock);
>  	while (nr_to_scan-- && !list_empty(&cache->c_list)) {
>  		entry = list_first_entry(&cache->c_list,
>  					 struct mb_cache_entry, e_list);
> -		if (entry->e_referenced || atomic_read(&entry->e_refcnt) > 2) {
> +		/* Drop initial hash reference if there is no user */
> +		if (entry->e_referenced ||
> +		    atomic_cmpxchg(&entry->e_refcnt, 1, 0) != 1) {

So here if the refcnt of an entry is 1. That means it is still in use right.
So the shrinker will do the atomic_cmpxchg and make it to 0. And then
delete the entry from the cache?
This will only happen for entry with just 1 reference count.

Is that correct understanding?

-ritesh


>  			entry->e_referenced = 0;
>  			list_move_tail(&entry->e_list, &cache->c_list);
>  			continue;
>  		}
>  		list_del_init(&entry->e_list);
>  		cache->c_entry_count--;
> -		/*
> -		 * We keep LRU list reference so that entry doesn't go away
> -		 * from under us.
> -		 */
>  		spin_unlock(&cache->c_list_lock);
> -		head = mb_cache_entry_head(cache, entry->e_key);
> -		hlist_bl_lock(head);
> -		/* Now a reliable check if the entry didn't get used... */
> -		if (atomic_read(&entry->e_refcnt) > 2) {
> -			hlist_bl_unlock(head);
> -			spin_lock(&cache->c_list_lock);
> -			list_add_tail(&entry->e_list, &cache->c_list);
> -			cache->c_entry_count++;
> -			continue;
> -		}
> -		if (!hlist_bl_unhashed(&entry->e_hash_list)) {
> -			hlist_bl_del_init(&entry->e_hash_list);
> -			atomic_dec(&entry->e_refcnt);
> -		}
> -		hlist_bl_unlock(head);
> -		if (mb_cache_entry_put(cache, entry))
> -			shrunk++;
> +		__mb_cache_entry_free(cache, entry);
> +		shrunk++;
>  		cond_resched();
>  		spin_lock(&cache->c_list_lock);
>  	}
> @@ -433,11 +408,6 @@ void mb_cache_destroy(struct mb_cache *cache)
>  	 * point.
>  	 */
>  	list_for_each_entry_safe(entry, next, &cache->c_list, e_list) {
> -		if (!hlist_bl_unhashed(&entry->e_hash_list)) {
> -			hlist_bl_del_init(&entry->e_hash_list);
> -			atomic_dec(&entry->e_refcnt);
> -		} else
> -			WARN_ON(1);
>  		list_del(&entry->e_list);
>  		WARN_ON(atomic_read(&entry->e_refcnt) != 1);
>  		mb_cache_entry_put(cache, entry);
> diff --git a/include/linux/mbcache.h b/include/linux/mbcache.h
> index 452b579856d4..2da63fd7b98f 100644
> --- a/include/linux/mbcache.h
> +++ b/include/linux/mbcache.h
> @@ -13,8 +13,16 @@ struct mb_cache;
>  struct mb_cache_entry {
>  	/* List of entries in cache - protected by cache->c_list_lock */
>  	struct list_head	e_list;
> -	/* Hash table list - protected by hash chain bitlock */
> +	/*
> +	 * Hash table list - protected by hash chain bitlock. The entry is
> +	 * guaranteed to be hashed while e_refcnt > 0.
> +	 */
>  	struct hlist_bl_node	e_hash_list;
> +	/*
> +	 * Entry refcount. Once it reaches zero, entry is unhashed and freed.
> +	 * While refcount > 0, the entry is guaranteed to stay in the hash and
> +	 * e.g. mb_cache_entry_try_delete() will fail.
> +	 */
>  	atomic_t		e_refcnt;
>  	/* Key in hash - stable during lifetime of the entry */
>  	u32			e_key;
> @@ -29,20 +37,20 @@ void mb_cache_destroy(struct mb_cache *cache);
>
>  int mb_cache_entry_create(struct mb_cache *cache, gfp_t mask, u32 key,
>  			  u64 value, bool reusable);
> -void __mb_cache_entry_free(struct mb_cache_entry *entry);
> +void __mb_cache_entry_free(struct mb_cache *cache,
> +			   struct mb_cache_entry *entry);
>  void mb_cache_entry_wait_unused(struct mb_cache_entry *entry);
> -static inline int mb_cache_entry_put(struct mb_cache *cache,
> -				     struct mb_cache_entry *entry)
> +static inline void mb_cache_entry_put(struct mb_cache *cache,
> +				      struct mb_cache_entry *entry)
>  {
>  	unsigned int cnt = atomic_dec_return(&entry->e_refcnt);
>
>  	if (cnt > 0) {
> -		if (cnt <= 3)
> +		if (cnt <= 2)
>  			wake_up_var(&entry->e_refcnt);
> -		return 0;
> +		return;
>  	}
> -	__mb_cache_entry_free(entry);
> -	return 1;
> +	__mb_cache_entry_free(cache, entry);
>  }
>
>  struct mb_cache_entry *mb_cache_entry_delete_or_get(struct mb_cache *cache,
> --
> 2.35.3
>
