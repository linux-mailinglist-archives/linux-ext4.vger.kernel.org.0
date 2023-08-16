Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49A577DE86
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Aug 2023 12:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbjHPKVU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Aug 2023 06:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243901AbjHPKU7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Aug 2023 06:20:59 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A75D2102
        for <linux-ext4@vger.kernel.org>; Wed, 16 Aug 2023 03:20:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CA578218A9;
        Wed, 16 Aug 2023 10:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692181249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmXZ8OQYDmZfEQ86mSf8Rh/lCNcwa0MBqsnVeyIwedo=;
        b=JKpfCjYjchf+64RN2HB3l0WTpLVXFaQEKTAj71dJNLAYRIjjoAzdi1zJLS+eft1PsWd6i4
        Tps7ak/WVLp24cmwR4gNf9Owens0njtYArpMARP3Vp+o0gUhl6ryBfOeO3d/6qJ73+CcwD
        3MOMCzLESDpdNEbQZHveWIm572hnOg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692181249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lmXZ8OQYDmZfEQ86mSf8Rh/lCNcwa0MBqsnVeyIwedo=;
        b=SwuVscS0sugonwgx4/vBsiipyaNnsuFWCmiaKwy99vuaFXW8nHTciXVnaZHQGJejbl10JO
        mR4ahNVu9UGev/BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD35F1353E;
        Wed, 16 Aug 2023 10:20:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 50orLgGj3GQfagAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 16 Aug 2023 10:20:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 53201A0769; Wed, 16 Aug 2023 12:20:49 +0200 (CEST)
Date:   Wed, 16 Aug 2023 12:20:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Georg Ottinger <g.ottinger@gmx.at>, jack@suse.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v1] ext2: fix datatype of block number in
 ext2_xattr_set2()
Message-ID: <20230816102049.oxunyinqjclxhsss@quack3>
References: <20230815100340.22121-1-g.ottinger@gmx.at>
 <259983C6-320F-4A21-86CA-B965D01494D7@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <259983C6-320F-4A21-86CA-B965D01494D7@dilger.ca>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Tue 15-08-23 06:18:43, Andreas Dilger wrote:
> On Aug 15, 2023, at 04:04, Georg Ottinger <g.ottinger@gmx.at> wrote:
> > ﻿I run a small server that uses external hard drives for backups. The
> > backup software I use uses ext2 filesystems with 4KiB block size and
> > the server is running SELinux and therefore relies on xattr. I recently
> > upgraded the hard drives from 4TB to 12TB models. I noticed that after
> > transferring some TBs I got a filesystem error "Freeing blocks not in
> > datazone - block = 18446744071529317386, count = 1" and the backup
> > process stopped. Trying to fix the fs with e2fsck resulted in a
> > completely corrupted fs. The error probably came from ext2_free_blocks(),
> > and because of the large number 18e19 this problem immediately looked
> > like some kind of integer overflow. Whereas the 4TB fs was about 1e9
> > blocks, the new 12TB is about 3e9 blocks. So, searching the ext2 code,
> > I came across the line in fs/ext2/xattr.c:745 where ext2_new_block()
> > is called and the resulting block number is stored in the variable block
> > as an int datatype. If a block with a block number greater than
> > INT32_MAX is returned, this variable overflows and the call to
> > sb_getblk() at line fs/ext2/xattr.c:750 fails, then the call to
> > ext2_free_blocks() produces the error.
> 
> It would be useful to also do a quick grep through the rest of the ext2
> code to check for this bug in other places calling ext2_mew_block() and
> similar calls.

I did actually check when merging the patch and all the other places are
storing returned block in ext2_fsblk_t.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
