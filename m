Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0B3861FE81
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 20:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiKGTXD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 14:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiKGTXA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 14:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9F72A26F
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 11:22:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2314D61044
        for <linux-ext4@vger.kernel.org>; Mon,  7 Nov 2022 19:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30433C433C1;
        Mon,  7 Nov 2022 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667848978;
        bh=duDc4mHK0s0Y6MhEsM8a7cCYdqwMuK3NtZVmQs0iE/U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCZT1524WwQ4bXUV1Q6ASqNuCczdf8ic90UFAbVD/kfPv2GV2AF3kBhhJLWbjauem
         J2bZZLrQMPpDphTjQDRFGt3QVYWSaFWdW9/zYPfMofmN6cATSsTBoTFfbKr+cART6q
         MlbuIey4lnEYIHRAoTy1wc3cG/bITL+pmTlM8+J3jSNXVogzGavUnI9UsUPKAmKzg6
         81EGZ51Fqj0WtAWo0epfZcnVIraePdyhHQd4Et6w4EWOyRzz03oQZC/NB5cCbUU5IT
         IxX+XcY4O4JCRBuUUy9HaabbzsZUYjHFy2CPbzNfFsna/GS6f0zDIGOh+5ElF2Fe1F
         kjggTdDuMUntA==
Date:   Mon, 7 Nov 2022 11:22:56 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Wang Shilong <wshilong@ddn.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Li Xi <lixi@ddn.com>, Sebastien Buisson <sbuisson@ddn.com>,
        Maloo <maloo@whamcloud.com>, Li Dongyang <dongyangli@ddn.com>,
        Andreas Dilger <adilger@whamcloud.com>
Subject: Re: [RFCv1 67/72] sec: support encrypted files handling in pfsck mode
Message-ID: <Y2lbEEtjhJwpbdRb@sol.localdomain>
References: <cover.1667822611.git.ritesh.list@gmail.com>
 <77a302b36f3576b9a9f7ef6e42bc1ef939227090.1667822612.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77a302b36f3576b9a9f7ef6e42bc1ef939227090.1667822612.git.ritesh.list@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 07, 2022 at 05:51:55PM +0530, Ritesh Harjani (IBM) wrote:

> sec: support encrypted files handling in pfsck mode
>

"sec:" => "e2fsck:".

> +/**
> + * Search policy matching @policy in @info->policies
> + * @ctx: e2fsck context
> + * @info: encrypted_file_info to look into
> + * @policy: the policy we are looking for
> + * @parent: (out) last known parent, useful to insert a new leaf
> + *	    in @info->policies
> + *
> + * Return: id of found policy on success, -1 if no matching policy found.
> + */
> +static inline int search_policy(e2fsck_t ctx, struct encrypted_file_info *info,
> +				union fscrypt_policy policy,
> +				struct rb_node **parent)
> +{
> +	struct rb_node *n = info->policies.rb_node;
> +	struct policy_map_entry *entry;
> +
> +	while (n) {
> +		int res;
> +
> +		*parent = n;
> +		entry = ext2fs_rb_entry(n, struct policy_map_entry, node);
> +		res = cmp_fscrypt_policies(ctx, &policy, &entry->policy);
> +		if (res < 0)
> +			n = n->rb_left;
> +		else if (res > 0)
> +			n = n->rb_right;
> +		else
> +			return entry->policy_id;
> +	}
> +	return -1;
> +}

Can this rbtree search code be reused by get_encryption_policy_id()?

Also, please use the existing constant NO_ENCRYPTION_POLICY instead of -1.

> +/*
> + * Merge @src encrypted info into @dest
> + */
> +int e2fsck_merge_encrypted_info(e2fsck_t ctx, struct encrypted_file_info *src,
> +				 struct encrypted_file_info *dest)
> +{
> +	struct rb_root *src_policies = &src->policies;
> +	__u32 *policy_trans;
> +	int i, rc = 0;
> +
> +	if (dest->file_ranges[src->file_ranges_count - 1].last_ino >
> +	    src->file_ranges[0].first_ino) {

There is an off-by-one error here.  How about writing it like the following so
that it looks like the check in append_ino_and_policy_id():

        if (src->file_ranges[0].first_ino <=
            dest->file_ranges[src->file_ranges_count - 1].last_ino) {

> +	/* First, deal with the encryption policy => ID map.

My understanding is that e2fsprogs follows the kernel coding style, where block
comments are formatted like the following:

	/*
	 * text
	 */

> +	 * Compare encryption policies in src with policies already recorded
> +	 * in dest. It can be similar policies, but recorded with a different

"similar" => "the same"

> +	while (!ext2fs_rb_empty_root(src_policies)) {
> +		struct policy_map_entry *entry, *newentry;
> +		struct rb_node *new, *parent = NULL;
> +		int existing_polid;
> +
> +		entry = ext2fs_rb_entry(src_policies->rb_node,
> +					struct policy_map_entry, node);
> +		existing_polid = search_policy(ctx, dest,
> +					       entry->policy, &parent);
> +		if (existing_polid >= 0) {

existing_polid != NO_ENCRYPTION_POLICY

> +			/* The policy in src is already recorded in dest,
> +			 * so just update its id.
> +			 */
> +			policy_trans[entry->policy_id] = existing_polid;
> +		} else {
> +			/* The policy in src is new to dest, so insert it
> +			 * with the next available id (its original id could
> +			 * be already used in dest).
> +			 */
> +			rc = ext2fs_get_mem(sizeof(*newentry), &newentry);
> +			if (rc)
> +				goto out_merge;

Use handle_nomem() for memory allocation failures?

> +                     newentry->policy_id = dest->next_policy_id++;
> +                     newentry->policy = entry->policy;
> +                     ext2fs_rb_link_node(&newentry->node, parent, &new);
> +                     ext2fs_rb_insert_color(&newentry->node,
> +                                            &dest->policies);
> +                     policy_trans[entry->policy_id] = newentry->policy_id;

This code also appears in get_encryption_policy_id().  Should it be refactored
into a helper function?

> +	/* Second, deal with the inode number => encryption policy ID map. */
> +	if (dest->file_ranges_capacity <
> +	    dest->file_ranges_count + src->file_ranges_count) {
> +		/* dest->file_ranges is too short, increase its capacity. */
> +		size_t new_capacity = dest->file_ranges_count +
> +			src->file_ranges_count;
> +
> +		/* Make sure we at least double the capacity. */
> +		if (new_capacity < (dest->file_ranges_capacity * 2))
> +			new_capacity = dest->file_ranges_capacity * 2;
> +
> +		/* We won't need more than the filesystem's inode count. */
> +		if (new_capacity > ctx->fs->super->s_inodes_count)
> +			new_capacity = ctx->fs->super->s_inodes_count;
> +
> +		rc = ext2fs_resize_mem(dest->file_ranges_capacity *
> +				       sizeof(struct encrypted_file_range),
> +				       new_capacity *
> +				       sizeof(struct encrypted_file_range),
> +				       &dest->file_ranges);
> +		if (rc) {
> +			fix_problem(ctx, PR_1_ALLOCATE_ENCRYPTED_INODE_LIST,
> +				    NULL);
> +			/* Should never get here */
> +			ctx->flags |= E2F_FLAG_ABORT;
> +			goto out_merge;
> +		}
> +
> +		dest->file_ranges_capacity = new_capacity;
> +	}

The exact allocation size that is needed is
'dest->file_ranges_count + src->file_ranges_count', so much of the above logic
is unnecessary.  Just reallocate that exact amount.

Also, handle_nomem() should be used.

> +	/* Copy file ranges from src to dest. */
> +	for (i = 0; i < src->file_ranges_count; i++) {
> +		/* Make sure to convert policy ids in src. */
> +		src->file_ranges[i].policy_id =
> +			policy_trans[src->file_ranges[i].policy_id];
> +		dest->file_ranges[dest->file_ranges_count++] =
> +			src->file_ranges[i];
> +	}

This needs to handle UNRECOGNIZED_ENCRYPTION_POLICY as a special case.

Also, shouldn't src->file_ranges be freed after this?

> +
> +out_merge:

I guess the "_merge" in "out_merge:" comes from the name of the containing
function?  It's a bit confusing.  Maybe just use "out:".

> diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> index 7345c96d..e7dc017c 100644
> --- a/e2fsck/pass1.c
> +++ b/e2fsck/pass1.c
> @@ -2411,9 +2411,6 @@ void e2fsck_pass1_run(e2fsck_t ctx)
>  		ctx->ea_block_quota_inodes = 0;
>  	}
>  
> -	/* We don't need the encryption policy => ID map any more */
> -	destroy_encryption_policy_map(ctx);

With this change, there are no callers of destroy_encryption_policy_map()
outside encrypted_files.c.  So absent any other changes,
destroy_encryption_policy_map() should be made into a static function and the
'if (info)' check inside it removed.

But, isn't there still some point where pass 1 is fully done and the encryption
policy ID map can be destroyed?  Maybe e2fsck_pass1_merge_encrypted_info()
should be calling destroy_encryption_policy_map() on the global_ctx after doing
the merge?

- Eric
