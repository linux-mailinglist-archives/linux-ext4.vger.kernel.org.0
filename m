Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3823E4BEAB0
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Feb 2022 20:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiBUSy5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Feb 2022 13:54:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiBUSyz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Feb 2022 13:54:55 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B24C7F
        for <linux-ext4@vger.kernel.org>; Mon, 21 Feb 2022 10:54:29 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id cm8so21677987edb.3
        for <linux-ext4@vger.kernel.org>; Mon, 21 Feb 2022 10:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zHdnlxp+6QZ5JDAEiaLocZ8jy1h1CjM+knGftC+SwA=;
        b=ZF8YuwM3tdQCkn7CfH8d1zAZaUpslyzBc6CmziaKGbKVeNhaYwKyCEOpqIwRrY3jP5
         P18kv2I1Iv+yBlVkwYMVWJe0ERG21REoyKay7UeZy+IPesb7fDl6O9L0pCi211oKbE/n
         kqzsaYCgVIOqkLQUYdCrb99Mx4KQ4Kz64GXW7NP7lYKWdrOkLk0WdqEo5O+YC24vyK1N
         sgIVL/qKCV9VGI1tTjSkjd84Jge6oaNMFwzmSAACt1URDHRue61evqjBeln+nnmU70V2
         LhGUEIXQrMSmGXL1VClwtBpHRa0esh+UelBJzTU8D1sQ/fhMCXo4jZqJq7WCiEwCcz5O
         6wlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zHdnlxp+6QZ5JDAEiaLocZ8jy1h1CjM+knGftC+SwA=;
        b=aZ5UA0lB5wSxVXT4No1RFjESahKgsM+hDoHNbx/q6ju3pY6fwMzctSG8yhnt2DL4hc
         E4CnoREaFnfV8z2aEtlnDHwLSPs9BWGpAZEMH8HF/HKlfPSsaPr2x2GEEcUJjeoV/y92
         GJ2eiyavIuvSjtcHTEFL3WGldgD65Yb6OVFi0uL6lVlk+lzJsMkzJXolyeMVuuO24n50
         ySpDsowJoOi0tnwMDWiPaO6CiRQ6fE5UAtLlL6n3o3U2eyYjQSSAYq53OzReDgsqqCGA
         UzEANRDuZwCAZYLwKxp6LVXJZEepwzJrdTBdOqJSy0SJFdJV3CaUWqdcPdjtczIoY+ZZ
         YudQ==
X-Gm-Message-State: AOAM531YPaW0hrHD0Gil/Y83pGydAhDhDIZHvaWPY9NX3V84LfNypqrr
        zMFA9fn+BsToKOggLIqRTmn3UxuHNsB2ru2oBFc=
X-Google-Smtp-Source: ABdhPJwgDOOg3Iu4Y3nSI4765En4QpJPeoiMGV8kaDI2DrrcFPPHYtn27Xj0CyBnFoTFB2RGKjfXUrvsjYDso5jstk4=
X-Received: by 2002:aa7:df1a:0:b0:409:5174:68a9 with SMTP id
 c26-20020aa7df1a000000b00409517468a9mr23336435edy.145.1645469667726; Mon, 21
 Feb 2022 10:54:27 -0800 (PST)
MIME-Version: 1.0
References: <20220221075938.g2lncbi7sxnnbrhr@riteshh-domain>
In-Reply-To: <20220221075938.g2lncbi7sxnnbrhr@riteshh-domain>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 21 Feb 2022 10:54:16 -0800
Message-ID: <CAD+ocbw8Z-mUiNQy2oDEzA3bBM=o-Gboi+r=HB4s2Hm6=-R8iQ@mail.gmail.com>
Subject: Re: Query regarding fast_commit replay of inode
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ritesh,

Thanks for bringing this up again. I think we should really document
this in the code. Let me first try to explain what we are doing and
then why we are doing it this way.

During fast commit replay (even for "add range" / "delete range"
tags), we always clear the bitmaps of whatever blocks we touch. For
example, even if new blocks are added to an inode, during the replay
phase of add range tag, we will still clear the bitmap to mark these
new blocks as free and at the end of the replay (i.e. after all the
tags have been replayed) we will traverse the "modified inodes list"
and mark all the blocks in these inodes as allocated.

We extend this logic to the replay of the "inode" tag as well. So
here's the high level flow of replay path wrt block bitmap handling:
- For every "add_range" / "del_range" tags in the FC log area:
   - Clear block bitmaps for all modified blocks in this tag.
- For every "inode" tag in the FC log area:
   - Clear all the blocks in that inode
   - Record that the inode is modified
- At the end of the replay phase
   - For each inode in the modified inode list:
      - Mark all the blocks in this inode as used

Let me try to describe the reason why we take this approach with an
example. Let's say there was an inode A of size 100 with following
extents:

Logical - Physical
[0-49] - unmapped
[50-99] - [1000 - 1049]

Let's say this inode changed to following mappings:

Logical - Physical
[0-49] - [1000 - 1049]
[50-99] - [1050 - 1099]

Let's say a fast commit was performed at this point. So, this would
translate to following logs in the fast commit area:

[ADD_RANGE, A, 0-49, 1000-1049] [ADD_RANGE, A, 50-99, 1050-1099]

After replaying the first tag, the inode's intermediate state would be
as follows:

Logical - Physical
[0-49] - [1000-1049]
[50-99] - [1000-1049]

During replay of the second tag, the logical to physical mapping of
50:99 has changed. So, we need to decide what to do with the old
blocks. If we mark the old physical blocks corresponding to 50-99
range as free on-disk, then that would result in block bitmap
inconsistency, since these blocks are actually being used somewhere
else. We can't simply leave these blocks as allocated either since
these blocks may actually not be used at all. Things get even more
complicated if these blocks are moved to a different file. So to
protect against such cases, what we simply do is that we defer setting
up the block bitmap correctly until the very end and just mark all the
blocks that we encounter during replays of different tags as free.

This was done mainly to protect against such cases in add range /
delete range operations, but I extended it to replay inode as well
just to be on the safer side. generic/311 provides a lot of good test
cases for such manipulations. We can see if removing clear_bb from
replay inode handling introduces any regressions.

Does this make sense?

- Harshad

On Sun, 20 Feb 2022 at 23:59, Ritesh Harjani <riteshh@linux.ibm.com> wrote:
>
> Hello Ted/Harshad,
>
> I think we did discuss this once before, but I am unable to recollect the exact
> reasoning for this. So question is - why do we have to call ext4_ext_clear_bb()
> from ext4_fc_replay_inode()?
>
> I was just thinking if this is suboptimal and if it can be optimized. But before
> working on that problem, I wanted to again understand the right reasoning behind
> choosing this approach in the first place.
>
> Could you please help with this again?
>
> ext4_fc_replay_inode()
> <..>
>         inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
>         if (!IS_ERR(inode)) {
>                 ext4_ext_clear_bb(inode);
>                 iput(inode);
>         }
> <..>
>
> I will document it this time, so that I don't have to keep coming to this
> everytime I look into fc replay code.
>
> Thanks again for your help!!
> -ritesh
