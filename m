Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492572ED97
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 23:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjFMVFi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 17:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjFMVFc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 17:05:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E1F1FC1
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 14:05:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 07B551FDD9;
        Tue, 13 Jun 2023 21:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686690327; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeeAwDWlJRVDgPH4ESSSQsshzln+Tcs4Eg9NmhQztj0=;
        b=tmuJkO+06jtVn3N1M68T4Dgd2nu7GIkGxCPqYFsCM+ZntDbPY0SwqaAAHYDejhcmtFrQra
        8Prcr5V1IENGhubSKNnZ0p3sPBbgcy6doDSKag4yQHwfBYWWh/C0i55/ykNqeyJBgbN114
        GkDBj7G0PI9K0ZAJymPbJ3FxiZb86rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686690327;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeeAwDWlJRVDgPH4ESSSQsshzln+Tcs4Eg9NmhQztj0=;
        b=z83TiQWbpgQ/Eae4+cVYzr8nyCcnFOwtDzYQponsH0C4btJftfw4yrrZ68UTAfdHNUuEVg
        kslgjniMD0jx9/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDAD813345;
        Tue, 13 Jun 2023 21:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Wd37ORbaiGTqMQAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 13 Jun 2023 21:05:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7B380A0755; Tue, 13 Jun 2023 23:05:26 +0200 (CEST)
Date:   Tue, 13 Jun 2023 23:05:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Aleksandr Nogikh <nogikh@google.com>, adilger.kernel@dilger.ca,
        jack@suse.com, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+af5e10f73dbff48f70af@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] UBSAN: shift-out-of-bounds in ext2_fill_super
 (2)
Message-ID: <20230613210526.ivz72esveqwrbwsr@quack3>
References: <00000000000079134b05fdf78048@google.com>
 <20230613180103.GC18303@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613180103.GC18303@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 13-06-23 14:01:03, Theodore Ts'o wrote:
> I wonder if we should have a separate syzkaller subsystem for ext2 (as
> distinct from ext4)?  The syz reproducer seems to know that it should
> be mounting using ext2, but also calls it an ext4 file system, which
> is a bit weird.  I'm guessing there is something specific about the
> syzkaller internals which might not make this be practical, but I
> thought I should ask.

Yeah, having ext2 driver as a separate subsystem makes sense to me since it
is completely different codebase.

> From the syz reproducer:
> 
> syz_mount_image$ext4(&(0x7f0000000100)='ext2\x00', ...)
> 
> More generally, there are a series of changes that were made to make
> ext4 to make it more robust against maliciously fuzzed superblocks,
> but we haven't necessarily made sure the same analogous changes have
> been made to ext2.  I'm not sure how critical this is in practice,
> since most distributions don't actually compile fs/ext2 and instead
> use CONFIG_EXT4_USE_FOR_EXT2 instead.  However, while we maintain ext2
> as a sample "simple" modern file system, I guess we should try to make
> sure we do carry those fixes over.
> 
> Jan, as the ext2 maintainer, do you have an opinion?

I agree, I try to fix these problems when syzbot finds them. For this one,
I've already sent a fix [1] (dropping remains of fragments support from ext2).

								Honza

[1] https://lore.kernel.org/all/20230613103012.22933-1-jack@suse.cz

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
