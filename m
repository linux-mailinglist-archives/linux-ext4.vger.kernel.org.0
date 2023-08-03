Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014C576DEBA
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 05:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjHCDJL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Aug 2023 23:09:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjHCDJG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Aug 2023 23:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11F930DF;
        Wed,  2 Aug 2023 20:09:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC0A61BB3;
        Thu,  3 Aug 2023 03:09:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F3DC433C9;
        Thu,  3 Aug 2023 03:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691032143;
        bh=QHLu2qchPO/2FuLK7r/oLQF/9G6LNB8Q8ZEpXXXTkSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L7wfC4q+Pl8/vsRZSWIT6fm8MB1uIfYZHRSI6FVw/eDejKD3DoNWc5aV9CWhc7iPK
         XOiHZGaMuWGeKGLgoLwy+6fkKhNYG4wf+Sbg6HFdRs4Q7lITUkI0VWLOhW47IHc7Hq
         yRtagflMZTs/Gt0vBkt1mWaFd90FSAgrqI1sXYUUEXMDFt+SprzlkLFhRq72udZfxB
         la7KgCJPe3b07W3IVfWMfLuvDsBqF+yMs+OUKDsIMjAEXB/4MhqkzAFd57JU46a8Vy
         8wYzKobXZL8DhlficQQ8JrUzYBv4NUKnmZECkmFZU+jg11ZYwJ9OpaipCaiT3I3XXk
         HveiJ93S9MNpQ==
Date:   Wed, 2 Aug 2023 20:09:03 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Stephen Zhang <starzhangzsd@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, Theodore Ts'o <tytso@mit.edu>,
        Zhang Yi <yi.zhang@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhangshida@kylinos.cn, stable@kernel.org
Subject: Re: [PATCH v3] ext4: Fix rec_len verify error
Message-ID: <20230803030903.GK11377@frogsfrogsfrogs>
References: <20230801112337.1856215-1-zhangshida@kylinos.cn>
 <20230801151828.GB11332@frogsfrogsfrogs>
 <A9ECDF14-95A1-4B1E-A815-4B6ABF4916C6@dilger.ca>
 <CANubcdUsDfiuGimNXjzoAF5ki8waCoFW31mg4vjpm073rS6+dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANubcdUsDfiuGimNXjzoAF5ki8waCoFW31mg4vjpm073rS6+dw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 03, 2023 at 09:52:53AM +0800, Stephen Zhang wrote:
> Andreas Dilger <adilger@dilger.ca> 于2023年8月2日周三 14:07写道：
> >
> > Not all of these cases are actual bugs.  The ext4_rec_len_from_disk()
> > function is only different for rec_len >= 2^16, so if it is comparing
> > rec_len against "12" or "sizeof(struct ...)" then the inequality will
> > be correct regardless of how it is decoded.
> >
> > That said, it makes sense to use ext4_rec_len_from_disk() to access
> > rec_len consistently throughout the code, since that avoids potential
> > bugs in the future.  We know the code will eventually will be copied
> > some place where rec_len >= 2^16 is actually important, and we may as
> > well avoid that bug before it happens.
> >
> >
> > One thing this discussion *does* expose is that ext4_rec_len_from_disk()
> > is hard-coded at compile time to differentiate between PAGE_SIZE > 64k
> > and PAGE_SIZE = 4K, because it was never possible to have blocksize >
> > PAGE_SIZE, so only ARM/PPC ever had filesystems with blocksize=64KiB
> > (and the Fujitsu Fugaku SPARC system with blocksize=256KiB).
> >
> > However, with the recent advent of the VM and IO layers allowing
> > blocksize > PAGE_SIZE this function will need to be changed to allow
> > the same on x86 PAGE_SIZE=4KiB systems.  Instead of checking
> >
> >   #if PAGE_SIZE >= 65536
> >
> > it should handle this based on the filesystem blocksize at runtime:
> >
> > static inline
> > unsigned int ext4_rec_len_from_disk(__le16 dlen, unsigned blocksize)
> > {
> >         unsigned len = le16_to_cpu(dlen);
> >
> >         if (blocksize < 65536)
> >                 return len;
> >
> >         if (len == EXT4_MAX_REC_LEN || len == 0)
> >                 return blocksize;
> >
> >         return (len & 65532) | ((len & 3) << 16);
> > }
> >
> > Strictly speaking, ((len & 65532) | ((len & 3) << 16) should equal "len"
> > for any filesystem with blocksize < 65536, but IMHO it is more clear if
> > the code is written this way.
> >
> > Similarly, the encoding needs to be changed to handle large records at
> > runtime for when we eventually allow ext4 with blocksize > PAGE_SIZE.
> >
> > static inline __le16 ext4_rec_len_to_disk(unsigned len, unsigned blocksize)
> > {
> >         BUG_ON(len > blocksize);
> >         BUG_ON(blocksize > (1 << 18));
> >         BUG_ON(len & 3);
> >
> >         if (len < 65536) /* always true for blocksize < 65536 */
> >                 return cpu_to_le16(len);
> >
> >         if (len == blocksize) {
> >                 if (blocksize == 65536)
> >                         return cpu_to_le16(EXT4_MAX_REC_LEN);
> >
> >                 return cpu_to_le16(0);
> >         }
> >
> >         return cpu_to_le16((len & 65532) | ((len >> 16) & 3));
> > }
> >
> 
> Hmm, at least it sounds reasonable to me based on my limited
> knowledge. However, I am not sure whether you want me to incorporate
> these changes into this particular commit or another patch within this
> submission.
> 
> By default, I will simply leave it for further discussion. Please let
> me know if you have any ideas.

ext4 doesn't support blocksize > PAGE_SIZE yet.  Don't worry about this
for now.

--D

> Cheers,
> Shida
> 
> >
> > Cheers, Andreas
> >
> >
> >
> >
> >
