Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49B801947DD
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Mar 2020 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZTtr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Mar 2020 15:49:47 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37211 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgCZTtr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Mar 2020 15:49:47 -0400
Received: by mail-ot1-f68.google.com with SMTP id g23so7282177otq.4
        for <linux-ext4@vger.kernel.org>; Thu, 26 Mar 2020 12:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iHe4siNzFkxQaIEc5fZ6aufrbN+L7q8/bKExZJ6cDCo=;
        b=THQwnp8yNtvjBHc3Qnwp3GNmSNdDKvBUZ+oGYULsHm6ia9hcwiDD91lV7yjJjPLLbP
         AKZf+wN10jhnfQs66PN4C74xZiCNXh05UOIKAFCFnyBKiy8OEeVO5CQpTNNn9OZ3PqXI
         Xo9QDgiMIfropxB62xUEJ0yf0t2TRCcucgNNxqhmHNpzqLsikmTqC/yDvC9FRytpXNXP
         pz5QhN6TkpeHQ9sNbTMKIvdDT3a3nsfOW/LGCdXkyS13Ly8ja0leK+vSdGwV+dWXTVS0
         vTZZKJBkHSX9exKFM0nsDfv96qvR86vE51QDPT1YNCzAJuamhpteQ/JFwcNHhSFRRBOC
         1kcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iHe4siNzFkxQaIEc5fZ6aufrbN+L7q8/bKExZJ6cDCo=;
        b=uEzAsFT8copM1mdi4X117h+kP++2u3Mt1NngJLgkbeteRX8S7B/8PxAe1ZnwwwofpS
         OPG3Bv1tUxCYYxUvoi6ELoZ0khPsC+ZHTdJPv/9chzCzN/p9Gu5i28Qq3vXS2/NhhgYr
         rFfs2YXcQbc2oVlAybMQ/btvcxx27eViBsGX23wp3dWYBz6pMChh9K1Z+wgyO4Rubsq8
         R13Roth5oKm88PPVjazVeY9ycvArYKrFBrzxtQ56cN+kNMdDUos1UjAqTVBtq0Q/YY4S
         B1R53kgVesIrjPBU4IBpK6q7V+Gf8c4gt+I+TSB+TRrHPmSKbCmYQt4/wjx1qRzQSO+E
         cxaw==
X-Gm-Message-State: ANhLgQ0B9FOSTsnMwoVhHVOP6J0s+s8HFnpSXXJmt8osslprhyUBm5ko
        ewoQPUyMeBO+sZ1L1O+S3dx7KpZYB+tQeOuPavIsWjXs
X-Google-Smtp-Source: ADFU+vtANyPSHKCrt3Z7ijPe7SDobHKQ37zzjhcHM/e1G8dza97qMlaupzY/7I5lfxU5LJgxox+tY0Zx5kyY4bKLegk=
X-Received: by 2002:a4a:e047:: with SMTP id v7mr6424723oos.49.1585252186143;
 Thu, 26 Mar 2020 12:49:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200325093728.204211-1-harshadshirwadkar@gmail.com>
 <20200325093728.204211-2-harshadshirwadkar@gmail.com> <04F44879-15DE-42EE-B87A-0690E9B13BB2@dilger.ca>
In-Reply-To: <04F44879-15DE-42EE-B87A-0690E9B13BB2@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 26 Mar 2020 12:49:35 -0700
Message-ID: <CAD+ocbxt5E+v8=zWQGuAPwtJMe_Qa8q9BhP1es05unaQ50ckkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ext4: shrink directories on dentry delete
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 25, 2020 at 3:06 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Mar 25, 2020, at 3:37 AM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> > But note that most of the shrinking happens during last 1-2% deletions
> > in an average case. Therefore, the next step here is to merge dx nodes
> > when possible. That can be achieved by storing the fullness index in
> > htree nodes. But that's an on-disk format change. We can instead build
> > on tooling added by this patch to perform reverse lookup on a dx
> > node and then reading adjacent nodes to check their fullness.
>
> Thank you for updating these patches again.  I haven't had a chance to look
> at them yet, but I hope to review the patches in the near future.
>
> As for storing the fullness on disk changing the on-disk format...  That is
> true, but the original htree implementation anticipated this and reserved
> space in the htree index to store the fullness, so it would not break the
> ability of older kernels to access directories with the fullness information.
>
Yeah, you are right, good to know that we have bits reserved already
and that wouldn't break older kernels if we use these in future.
> I think if you used just a few bits (maybe just 2) to store:
> 0 = unset (every directory today)
> 1 = under 20% full
> 2 = under 40% full
> 3 = under 60% full
>
> or similar.  It doesn't matter if they are more full since they won't be
> candidates for merging, and then lazily update the htree index fullness
> as entries are removed, this will simplify the shrinking process, and will
> avoid the need to repeatedly scan the leaf blocks to see if they are empty
> enough for merging.  It wouldn't be any worse *not* to store these values
> on disk after the first time a "0 = unset" entry was found and not merged,
> or setting the fullness on the merged block if it is merged, and running
> "e2fsck -D" can easily update the fullness values.
>
> The benefit of using 20%, 40%, and 60% as the fullness markers is that it
> is possible to either merge adjacent 60% and 40% blocks or alternately a
> 60% and two adjacent 20% blocks.  Also, since these values are very coarse
> they would not need to be updated frequently.  If the values are slightly
> outdated, then it is again not worse than the "always scan" model (one scan
> and the fullness would be updated), but more efficient than repeat scanning.
>
> Using only two bits for fullness also leaves two bits free for future use.

Thanks Andreas, that makes sense. This kind of merging will require
lot of tooling provided in this patch - for example swapping out freed
block with last block to not leave any holes. So, my hope is that we
get this patch in first and thereby get a step closer to coalescing
solution.

Thanks,
Harshad
>
> Cheers, Andreas
>
>
>
>
>
