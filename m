Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993A3532FA9
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237930AbiEXRbo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiEXRbn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 13:31:43 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8751E3D1;
        Tue, 24 May 2022 10:31:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c14so17055710pfn.2;
        Tue, 24 May 2022 10:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kFuZ9N+bF1LsZStC5mzy+qqX8B+em2hfNM7QZu/oT0s=;
        b=dtUHGGvLp9UVnVv4i3d3f4usrVReBiYCXLgE9sUasWYw3k5QKmfBQmn4StK3E7Kg7k
         0kwMiUCxoIMfzLYgC86pdGsjafMtRP/USyqEZTWokOfQhmYFuZjbxKwjMGycm4li/Z6t
         e0v7G646WsFM/VJ2rTYIdaFlfUK+QYEKezCH4GWVQftBz72jd7EBz8VCyXz2F8Se9JOL
         c6zGDgj83gkn883ZY1mwXwiWeBn/J9yyoDBeYZYUqoZnloJZU2YhZEbx27H0woLluK/s
         6sj9Czj5KUT37J6TYJQI7Mt7tDV2U1F0U7jeBrKLl2VhGGn98el6THATSyiFxG8/6qPV
         qzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kFuZ9N+bF1LsZStC5mzy+qqX8B+em2hfNM7QZu/oT0s=;
        b=deiBt6uIYKn2DXSKClslgqzgRjrQzsKmzwwVOCfZ6Gm64r7Yn82U043hkHP5xaBfQv
         /TjKrOc2MmixlxxOq32oNhuqsDTsxNvA1FJ6s877wlm9eQ77/iTVzLHCv7UK3qUcTZJG
         LZYUVG0sF8DBQS0xXWo5xYWvPF6myyXuw/nW4ikhyorQXvBjCIiiXPuc72yEfd7/YQB9
         +oHuLccbLou6lHl1iFnf++ppH3s4Be9aDImLVzVlIwjDQMJ1jM5qsYFQDARP08rlBpwS
         reOS72kKdJ+UFLdh0UJ9Y3Z73sXoE4Y9DLuiT3r0YbUCE5LU/X1gWo2A+5bIH+dAT2AQ
         3GvQ==
X-Gm-Message-State: AOAM531k3kmsN2SKNqAN4xQTD9iRE15+qsVC2K8Evd4vcKnuIXp8bSYH
        40ayODoEyKDyQam7ZoQhpaU93sPibdA=
X-Google-Smtp-Source: ABdhPJwlbuze1usQ+UcKp5UqxHpehCJWDI8CCcaM+yLZfmI+iAOLYniF2Z7md6qa11lActiWXjPBsQ==
X-Received: by 2002:a62:484:0:b0:50d:a020:88e5 with SMTP id 126-20020a620484000000b0050da02088e5mr29204447pfe.51.1653413500999;
        Tue, 24 May 2022 10:31:40 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a02e:de5c:9e42:9257])
        by smtp.gmail.com with ESMTPSA id bb5-20020a170902bc8500b0015e8d4eb24dsm721940plb.151.2022.05.24.10.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 10:31:40 -0700 (PDT)
Date:   Tue, 24 May 2022 23:01:35 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220524173135.imboagpi3iqav2cg@riteshh-domain>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
 <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
 <20220523210806.yeapg54ctleocwdn@quack3.lan>
 <20220524062655.ddiltnfxxhlelfgb@riteshh-domain>
 <20220524093933.bittzsrrpddttnab@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524093933.bittzsrrpddttnab@quack3.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/24 11:39AM, Jan Kara wrote:
> On Tue 24-05-22 11:56:55, Ritesh Harjani wrote:
> > On 22/05/23 11:08PM, Jan Kara wrote:
> > > On Tue 24-05-22 01:38:44, Ritesh Harjani wrote:
> > > > On 22/05/21 09:42PM, Baokun Li wrote:
> > > > > When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> > > > > "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> > > > > that the fe_logical is not in the allocated range.
> > > >
> > > > Sounds about right to me based on the logic in ext4_mb_use_inode_pa().
> > > > We try to allocate/preallocate such that ac->ac_o_ex.fe_logical should fall
> > > > within the preallocated range. So if our start or start + size doesn't include
> > > > fe_logical then it is a bug in the ext4_mb_normalize_request() logic.
> > >
> > > I agree ac->ac_o_ex.fe_logical is a goal block. But AFAIK it never was a
> > > hard guarantee that we would allocate extent that includes that block. It
> >
> > Agree that the guarantee is not about the extent which finally gets allocated.
> > It is only within ext4_mb_normalize_request() that the "start" and "size"
> > variable calculations is done in such a way that the ac->ac_o_ex.fe_logical
> > block will always fall within the "start" & "end" boundaries after
> > normalization.
> >
> > That is how it also updates the goal block at the end too. ac->ac_g_ex.
> >
> > > was always treated as a hint only. In particular if you look at the logic
> > > in ext4_mb_normalize_request() it does shift the start of the allocation to
> > > avoid preallocated ranges etc.
> >
> > Yes, I checked the logic of ext4_mb_normalize_request() again.
> > As I see it (I can be wrong, so please correct me), there is always an attempt
> > to make "start" & "start + size" such that it covers ac->ac_o_ex.fe_logical
> > except just one change where we are trimming the size of the request to only
> > EXT4_BLOCKS_PER_GROUP.
> >
> > For e.g. when it compares against preallocated ranges. It has a BUG() which
> > checks if the ac->ac_o_ex.fe_logical already lies in the preallocated range.
> > Because then we should never have come here to do allocation of a new block.
> >
> > 4143                 /* PA must not overlap original request */
> > 4144                 BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
> > 4145                         ac->ac_o_ex.fe_logical < pa->pa_lstart));
> > <...>
> > 4152                 BUG_ON(pa->pa_lstart <= start && pa_end >= end);
> >
> > Then after skipping the preallocated regions which doesn't fall in between
> > "start" and "end"...
> >
> > 4147                 /* skip PAs this normalized request doesn't overlap with */
> > 4148                 if (pa->pa_lstart >= end || pa_end <= start) {
> > 4149                         spin_unlock(&pa->pa_lock);
> > 4150                         continue;
> > 4151                 }
> >
> > ...it adjusts "start" and "end" boundary according to allocated PAs boundaries
> > such that fe_logical is always in between "start" and "end".
> >
> > 4154                 /* adjust start or end to be adjacent to this pa */
> > 4155                 if (pa_end <= ac->ac_o_ex.fe_logical) {
> > 4156                         BUG_ON(pa_end < start);
> > 4157                         start = pa_end;
> > 4158                 } else if (pa->pa_lstart > ac->ac_o_ex.fe_logical) {
> > 4159                         BUG_ON(pa->pa_lstart > end);
> > 4160                         end = pa->pa_lstart;
> > 4161                 }
> >
> >
> >
> > > so I don't see how we are guaranteed that
> > > ext4_mb_normalize_request() will result in an allocation request that
> > > includes ac->ac_o_ex.fe_logical.
> >
> > It could be I am wrong, but looks like ext4_mb_normalize_request() keeps
> > ac->ac_o_ex.fe_logical within "start" and "end" of allocation request.
> > And then updates the goal block.
> >
> > 4196         ac->ac_g_ex.fe_logical = start;
> > 4197         ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
> >
> > Thoughts?
>
> Right, after some more inspection the only thing I'm concerned about is:
>
>         /* don't cover already allocated blocks in selected range */
>         if (ar->pleft && start <= ar->lleft) {
>                 size -= ar->lleft + 1 - start;
>                 start = ar->lleft + 1;
>         }
>
> which can shift start beyond ac->ac_o_ex.fe_logical if the block would be
> already allocated. But I guess in that case we should not be calling
> ext4_mb_normalize_request()? ... some more code digging .. Yes, that is
> guaranteed in how lleft is initialized in ext4_ext_map_blocks().

Yes.

> So OK, I withdraw my objection to the stronger check but the changelog really needs

Thanks Jan for confirming it.


> to do a better job to explain why the stronger condition should be true.

Agreed.


diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 252c168454c7..9e7c145e9aa2 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4179,7 +4179,22 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
        }
        rcu_read_unlock();

-       if (start + size <= ac->ac_o_ex.fe_logical &&
+       /*
+        * In this function "start" and "size" are normalized for better
+        * alignment and length such that we could preallocate more blocks.
+        * This normalization is done such that original request of
+        * ac->ac_o_ex.fe_logical & fe_len should always lie within "start" and
+        * "size" boundaries.

Does above comment look good to you?


+        * (Note fe_len can be relaxed since FS block allocation API does not
+        * provide gurantee on number of contiguous blocks allocation since that
+        * depends upon free space left, etc).
+        * In case of inode pa, later we use the allocated blocks
+        * [pa_start + fe_logical - pa_lstart, fe_len/size] from the preallocated
+        * range of goal/best blocks [start, size] to put it at the
+        * ac_o_ex.fe_logical extent of this inode.
+        * (See ext4_mb_use_inode_pa() for more details)
+        */

^^^ We can even put more info if needed (maybe in commit message?)

+       if (start + size <= ac->ac_o_ex.fe_logical ||
                        start > ac->ac_o_ex.fe_logical) {
                ext4_msg(ac->ac_sb, KERN_ERR,
                         "start %lu, size %lu, fe_logical %lu",

FYI - I ran the fsstress test (with -g 256) shared by Baokun with only above
change (&& -> ||) and not the original fix. And I see that we can hit this
mentioned BUG() now.

<logs>
========
[  599.619875] EXT4-fs (loop2): start 692, size 196, fe_logical 982
	...I think we should also add (orig_size >> bsbits) in above print msg ^^

[  599.621043] ------------[ cut here ]------------
[  599.625099] kernel BUG at fs/ext4/mballoc.c:4188!

-ritesh

