Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9953402C
	for <lists+linux-ext4@lfdr.de>; Wed, 25 May 2022 17:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiEYPQU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 May 2022 11:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiEYPQT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 May 2022 11:16:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6261403E;
        Wed, 25 May 2022 08:16:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 31so19135520pgp.8;
        Wed, 25 May 2022 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FSL6dJ9rwpCvjXAcZwHY+rJfGedBJIPe6IX97TlYKno=;
        b=UgKdideDTVez9apFYp/oC3+IghsvQvPPY68fUW+k7EMTEN9nuFguvM5Jw7MsY9xT9i
         qR+kEnTb58Bi5WVU2R3p3bT08kRSMc7z54TzBIBeFNENhlkzGyaEgd6FvIYym2WZjKUt
         C9tZZBCfyGvrAbEJA+QUkuajlQ/ANG+JviKI1ohxBXi5CkPiR6Sdg3lmXPfrwmA3iWsA
         gDLloGvjl3rnW6MOdj7jZePId/1PNCKD3WOBWyk1O66wLnARvohaUDNauuIPFKEtCYd4
         WeAcyKQVVg4xkmohp0EdzONUgxlPYCds1uvJWffJnz1YjMN2t9y3tsoj5KESzNa5ffZB
         dZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FSL6dJ9rwpCvjXAcZwHY+rJfGedBJIPe6IX97TlYKno=;
        b=HxPLDKEwMZaH3N0q4CABydTm7jDbOmbU2OZQcMc+qSge1kIRCtWlhZByKoxTf5NxWI
         jZPmdm6HQ0s/uNGruC8yzwmtLhJmaz0dZ1dv7X1hRLYBMRNubJ7AXn9sTS7BEPDojZ7y
         aKtGg6xIWjAlLrmq0YbV2VJFgfbfeyG3xTK/qPT/wrjuH1K+/cACQZcdWTnVkQquJX1h
         f3kivsMtB5n1G8jlQRWs6IeyJzTMQawYjwbqihNsPJ1q/8FfIzfGTDtoHVhSJ5Fk/iMs
         NYtXbur+b+fo0Ciw/2xdpSQdAwUllavvwCJUGyLE7qw5HrPEE7/pKdjk9WduXHvlR5LZ
         h1OA==
X-Gm-Message-State: AOAM533DEpZPN1Bj8OWfEVGrmYCImwhpp09LH41f/aM18JlmwtxOZo4H
        AT8ZjahRXtRxxkL92yO+b5c=
X-Google-Smtp-Source: ABdhPJw13j2jLRiQy6vRB8HT7xwR4jNBXmsgPNFRvPaPsNCQ5uJwjkETcR5MCVFhZIbZx0QlbF0f5Q==
X-Received: by 2002:a65:6045:0:b0:399:3a5e:e25a with SMTP id a5-20020a656045000000b003993a5ee25amr28200744pgp.139.1653491777982;
        Wed, 25 May 2022 08:16:17 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:a782:286b:de51:79ce])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090a390c00b001dbe7ccdd4dsm1758446pjb.10.2022.05.25.08.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:16:17 -0700 (PDT)
Date:   Wed, 25 May 2022 20:46:12 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ye Bin <yebin10@huawei.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext4: fix super block checksum incorrect after
 mount
Message-ID: <20220525151612.an7xysp242urynbp@riteshh-domain>
References: <20220525012904.1604737-1-yebin10@huawei.com>
 <20220525075123.rx5v7fe6ocn354wn@riteshh-domain>
 <20220525115400.kr3urpp3cf3hybvi@quack3.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220525115400.kr3urpp3cf3hybvi@quack3.lan>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/25 01:54PM, Jan Kara wrote:
> On Wed 25-05-22 13:21:23, Ritesh Harjani wrote:
> > On 22/05/25 09:29AM, Ye Bin wrote:
> > > We got issue as follows:
> > > [home]# mount  /dev/sda  test
> > > EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> > > [home]# dmesg
> > > EXT4-fs (sda): warning: mounting fs with errors, running e2fsck is recommended
> > > EXT4-fs (sda): Errors on filesystem, clearing orphan list.
> > > EXT4-fs (sda): recovery complete
> > > EXT4-fs (sda): mounted filesystem with ordered data mode. Quota mode: none.
> > > [home]# debugfs /dev/sda
> > > debugfs 1.46.5 (30-Dec-2021)
> > > Checksum errors in superblock!  Retrying...
> > >
> > > Reason is ext4_orphan_cleanup will reset ‘s_last_orphan’ but not update
> > > super block checksum.
> > > To solve above issue, defer update super block checksum after ext4_orphan_cleanup.
> >
> > I agree with the analysis. However after [1], I think all updates to superblock
> > (including checksum computation) should be done within buffer lock.
> > (lock_buffer(), unlock_buffer()).
> >
> > [1]: https://lore.kernel.org/all/20201216101844.22917-4-jack@suse.cz/
>
> So technically you're right that we should hold buffer lock all the time
> from before we modify superblock buffer until we recompute the checksum (so
> that we avoid writing superblock with mismatched checksum). To do this we'd
> have to put checksum recomputations and superblock buffer locking into
> ext4_orphan_cleanup() around setting of es->s_last_orphan (in three places
> there AFAICS). A bit tedious but it would actually also fix a (theoretical)
> race that someone decides to write out superblock after we set
> s_last_orphan but before we set the checksum.

Ok. Although (I think) it can still be done at just one place before returning
from ext4_orphan_cleanup().
But I agree it is mostly a theoretical race (in fact since this is happening
during mount, I am not sure if it is even possible?) and there might not
be any value addition in doing so by complicating it too much.

>
> Overall I'm not convinced this is really necessary so I'd be OK even with
> what Ye suggested. That is IMHO better than mostly pointless locking just
> around checksum computation because that just makes reader wonder why is it
> needed...

Sure, yes. Thanks for explaining it.

-ritesh

>
> 								Honza
>
> >
> > With lock changes added, feel free to add -
> >
> > Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com>
> >
> >
> > >
> > >
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >  fs/ext4/super.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index f9a3ad683b4a..c47204029429 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -5300,14 +5300,6 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > >  		err = percpu_counter_init(&sbi->s_freeinodes_counter, freei,
> > >  					  GFP_KERNEL);
> > >  	}
> > > -	/*
> > > -	 * Update the checksum after updating free space/inode
> > > -	 * counters.  Otherwise the superblock can have an incorrect
> > > -	 * checksum in the buffer cache until it is written out and
> > > -	 * e2fsprogs programs trying to open a file system immediately
> > > -	 * after it is mounted can fail.
> > > -	 */
> > > -	ext4_superblock_csum_set(sb);
> > >  	if (!err)
> > >  		err = percpu_counter_init(&sbi->s_dirs_counter,
> > >  					  ext4_count_dirs(sb), GFP_KERNEL);
> > > @@ -5365,6 +5357,14 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
> > >  	EXT4_SB(sb)->s_mount_state |= EXT4_ORPHAN_FS;
> > >  	ext4_orphan_cleanup(sb, es);
> > >  	EXT4_SB(sb)->s_mount_state &= ~EXT4_ORPHAN_FS;
> > > +	/*
> > > +	 * Update the checksum after updating free space/inode counters and
> > > +	 * ext4_orphan_cleanup. Otherwise the superblock can have an incorrect
> > > +	 * checksum in the buffer cache until it is written out and
> > > +	 * e2fsprogs programs trying to open a file system immediately
> > > +	 * after it is mounted can fail.
> > > +	 */
> > > +	ext4_superblock_csum_set(sb);
> > >  	if (needs_recovery) {
> > >  		ext4_msg(sb, KERN_INFO, "recovery complete");
> > >  		err = ext4_mark_recovery_complete(sb, es);
> > > --
> > > 2.31.1
> > >
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
