Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E84106FBBF5
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 02:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjEIA0K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 20:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjEIA0H (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 20:26:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08C049C2
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 17:26:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39B9821DBD;
        Tue,  9 May 2023 00:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1683591962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txNhsEKdTH9UqPS1tyV0CRRcef6uQM7tsm8elksz6rk=;
        b=fiUA8lzwvGQ0dVqYAZ2x4M55bhsnmNR8d8Fch9Ba4HElWlxfUWKg4CT7AABrJGm20YKyYR
        n15hMg7/RGeSDcwcodSGPYKP3zYqGf/eN6Wqu8YAH5tXMkAGsbWP+br6KWjrOYztOlCaQT
        5fJsu8Xm9fVJIxr5BVl2SbPXre/x6Cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1683591962;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=txNhsEKdTH9UqPS1tyV0CRRcef6uQM7tsm8elksz6rk=;
        b=81wUZMHiOBgWx2OnM5iJKO50Vqf5XsUj1DjvhJjfcGC5GCrLHtNmGvekqM25Q7i75k0UZv
        X9Cjd5TMuohWPUBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E942A134B2;
        Tue,  9 May 2023 00:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VwJ1OBmTWWQ7CAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 09 May 2023 00:26:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4F285A074D; Tue,  9 May 2023 02:25:59 +0200 (CEST)
Date:   Tue, 9 May 2023 02:25:59 +0200
From:   Jan Kara <jack@suse.cz>
To:     youling257 <youling257@gmail.com>
Cc:     jack@suse.cz, hch@infradead.org, hch@lst.de,
        linux-ext4@vger.kernel.org, ritesh.list@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v4 12/13] ext4: Stop providing .writepage hook
Message-ID: <20230509002559.tudxwmu2xn3valw3@quack3>
References: <20221207112722.22220-12-jack@suse.cz>
 <20230508175108.6986-1-youling257@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230508175108.6986-1-youling257@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

On Tue 09-05-23 01:51:08, youling257 wrote:
> I using linux mainline kernel on android.
> https://github.com/youling257/android-mainline/commits/6.4
> https://github.com/youling257/android-mainline/commits/6.3 "ext4: Stop
> providing .writepage hook" cause some android app unable to read
> storage/emulated/0 files, i need to say android esdfs file system
> storage/emulated is ext4 data/media bind mount.  I want to ask, why
> android storage/emulated need .writepage hook?

Honestly, I don't know. I guess you need to look into implementation of
esdfs in the Android kernel and why it needs filesystem's .writepage
hook...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
