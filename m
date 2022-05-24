Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6724053231C
	for <lists+linux-ext4@lfdr.de>; Tue, 24 May 2022 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbiEXG1I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 May 2022 02:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbiEXG1E (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 May 2022 02:27:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C8570930;
        Mon, 23 May 2022 23:27:01 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gg20so15960919pjb.1;
        Mon, 23 May 2022 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2Xp5YDIW1x1ffxr3H7IBHm82ti4sGYqzIEKucwhtugQ=;
        b=DH9eiGdhfjDcCoPK5omgotXHG7ikBd6+qocAX35Pl8SuRlC5KWwqX+M9yovM/h3Ox9
         xBdgPO7sbhD2AU/q+z13POvDAobU6pp6Hisus0iiwama7nudhJM5u2bK1MrEOi1ld29N
         KOX0Mtltf3+J5A6SGFZhYr3dFBdGKNfdsfTcZw0f9U7xOnbcayi3wbh+A35o5CUpPXIy
         3NjM9wc/ATD7Ui/n8RKMdRDPZVDHVXcSkby4vrXnOa63/0fxL/lFYYOGC36B07fHyO15
         RPSvpm0oVGBVBWuW8C3NkxBLeSfjvz92Z79n6PGrBxw5ccwVnGFvPxxaxiWu75OWr/eM
         w5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Xp5YDIW1x1ffxr3H7IBHm82ti4sGYqzIEKucwhtugQ=;
        b=He5JNY8UzPov3m+Qcbg3jj0ygflatbaXgww7jmH87QVQA8rhJmRYmIm5GnUggZtpvM
         +N1Ew3qnXfNFkr+jQ6Q71eRha7GwlO2FIuLsA21h+k7daEM6OddtQtdliGyS4huVay+g
         ZHtSDFw/o3MR1QXYixsEUVuxcFnVRu5wVPIyyZ5Tw5ydkYxZD5m9QDM8H++p7GqKprzR
         WZYh5yLZEUUApq4Xw5gKfyPEUeIX5okkFZFXselfq5M6pTTnEmPsZ1TyoGr3/6MESqn8
         0v4Nv3c99zI/7QxLKV+gnGQzDpFm+qeNbkcRtx63w2PQlIVD1STeQl3hLuppLtAnpKXO
         rtfw==
X-Gm-Message-State: AOAM530rdUYnN1u0Ij38tC+IYgjDN2+MSy++6YkA0Fslq9wjhSg4qGh8
        wL4I8JIwYm4ewMYuCaFzfrM=
X-Google-Smtp-Source: ABdhPJz2NHF8ZCDZdZJ4mzTv3PAZBUDMzhqY63Y7vKLOYnBXYaaZXKheooUgiP7qVIN4xrZhGR74ig==
X-Received: by 2002:a17:90a:7082:b0:1e0:876a:3dd8 with SMTP id g2-20020a17090a708200b001e0876a3dd8mr156389pjk.68.1653373620490;
        Mon, 23 May 2022 23:27:00 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:78:9648:3f92:a905])
        by smtp.gmail.com with ESMTPSA id s18-20020aa78bd2000000b0050dc76281e0sm8281687pfd.186.2022.05.23.23.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 23:27:00 -0700 (PDT)
Date:   Tue, 24 May 2022 11:56:55 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: correct the judgment of BUG in
 ext4_mb_normalize_request
Message-ID: <20220524062655.ddiltnfxxhlelfgb@riteshh-domain>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-3-libaokun1@huawei.com>
 <20220523200844.fal3pmp7epid3rvv@riteshh-domain>
 <20220523210806.yeapg54ctleocwdn@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220523210806.yeapg54ctleocwdn@quack3.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/23 11:08PM, Jan Kara wrote:
> On Tue 24-05-22 01:38:44, Ritesh Harjani wrote:
> > On 22/05/21 09:42PM, Baokun Li wrote:
> > > When either of the "start + size <= ac->ac_o_ex.fe_logical" or
> > > "start > ac->ac_o_ex.fe_logical" conditions is met, it indicates
> > > that the fe_logical is not in the allocated range.
> >
> > Sounds about right to me based on the logic in ext4_mb_use_inode_pa().
> > We try to allocate/preallocate such that ac->ac_o_ex.fe_logical should fall
> > within the preallocated range. So if our start or start + size doesn't include
> > fe_logical then it is a bug in the ext4_mb_normalize_request() logic.
>
> I agree ac->ac_o_ex.fe_logical is a goal block. But AFAIK it never was a
> hard guarantee that we would allocate extent that includes that block. It

Agree that the guarantee is not about the extent which finally gets allocated.
It is only within ext4_mb_normalize_request() that the "start" and "size"
variable calculations is done in such a way that the ac->ac_o_ex.fe_logical
block will always fall within the "start" & "end" boundaries after
normalization.

That is how it also updates the goal block at the end too. ac->ac_g_ex.

> was always treated as a hint only. In particular if you look at the logic
> in ext4_mb_normalize_request() it does shift the start of the allocation to
> avoid preallocated ranges etc.

Yes, I checked the logic of ext4_mb_normalize_request() again.
As I see it (I can be wrong, so please correct me), there is always an attempt
to make "start" & "start + size" such that it covers ac->ac_o_ex.fe_logical
except just one change where we are trimming the size of the request to only
EXT4_BLOCKS_PER_GROUP.

For e.g. when it compares against preallocated ranges. It has a BUG() which
checks if the ac->ac_o_ex.fe_logical already lies in the preallocated range.
Because then we should never have come here to do allocation of a new block.

4143                 /* PA must not overlap original request */
4144                 BUG_ON(!(ac->ac_o_ex.fe_logical >= pa_end ||
4145                         ac->ac_o_ex.fe_logical < pa->pa_lstart));
<...>
4152                 BUG_ON(pa->pa_lstart <= start && pa_end >= end);

Then after skipping the preallocated regions which doesn't fall in between
"start" and "end"...

4147                 /* skip PAs this normalized request doesn't overlap with */
4148                 if (pa->pa_lstart >= end || pa_end <= start) {
4149                         spin_unlock(&pa->pa_lock);
4150                         continue;
4151                 }

...it adjusts "start" and "end" boundary according to allocated PAs boundaries
such that fe_logical is always in between "start" and "end".

4154                 /* adjust start or end to be adjacent to this pa */
4155                 if (pa_end <= ac->ac_o_ex.fe_logical) {
4156                         BUG_ON(pa_end < start);
4157                         start = pa_end;
4158                 } else if (pa->pa_lstart > ac->ac_o_ex.fe_logical) {
4159                         BUG_ON(pa->pa_lstart > end);
4160                         end = pa->pa_lstart;
4161                 }



> so I don't see how we are guaranteed that
> ext4_mb_normalize_request() will result in an allocation request that
> includes ac->ac_o_ex.fe_logical.

It could be I am wrong, but looks like ext4_mb_normalize_request() keeps
ac->ac_o_ex.fe_logical within "start" and "end" of allocation request.
And then updates the goal block.

4196         ac->ac_g_ex.fe_logical = start;
4197         ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);

Thoughts?

-ritesh
