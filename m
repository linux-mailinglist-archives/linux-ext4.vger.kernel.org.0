Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CA56A671A
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 05:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjCAEtd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 23:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCAEtb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 23:49:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C39BBBA5
        for <linux-ext4@vger.kernel.org>; Tue, 28 Feb 2023 20:49:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCF7361181
        for <linux-ext4@vger.kernel.org>; Wed,  1 Mar 2023 04:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF68C433D2;
        Wed,  1 Mar 2023 04:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677646167;
        bh=hnKmGDXcDUXsuqk+72JTvL8xav9po7qTkoOuX1+sweA=;
        h=Date:From:To:Cc:Subject:From;
        b=msokCHXYh0Me0WGJT9i23RoQqMKTjbxmkUMFt3D9pFy+GtRgHTqywrW3zOyRM+O3S
         eBZCXNRirkYwxQXK6SiYII02Vw+1QR9Aq/d9RrzryECENSehDBO5O6t2Anyf0/9AoS
         oUk8fTP0soas7dHZ7S/mXTqbDR2oOBIA2uJuMLqvG2scOLoFwWLSFR44kF7hGTQ6Tr
         HNaoQPnwXGTWGVUlfn0l1xRY+QT1nY/SCo9uptUvf2/pGCqNelqel5ByDwYP2E67jZ
         2cz/NyTtQzdG9I76jccvLFnkwqH/0zlMaOU/tYqywMnMVynJimQCQcfCzxV6UHJGIQ
         MHQAVhOtIiZ8A==
Date:   Tue, 28 Feb 2023 20:49:25 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: What is the purpose of windows_io_manager in e2fsprogs?
Message-ID: <Y/7ZVZ5Wv0NnzT4g@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Paulo,

I'm very confused by all the new Windows-specific code that you added to
e2fsprogs in the following commit:

	commit d04f34a050e3334456e9ee80f95869dc47b0fd9f
	Author: Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
	Date:   Tue Dec 22 15:15:50 2020 -0300

	    libext2fs: add a Windows implementation of the IO manager

So, Windows now has a windows_io_manager, which is used instead of
unix_io_manager.  That *sounds* like something that makes sense.

But actually, AFAICT, Windows used unix_io_manager before, and it more or less
works fine.  The basic UNIX I/O functions like open(), read(), write(), etc.
are available in MSVCRT on Windows.  (Often with quirks, but they are
available.)  MinGW provides some compatibility definitions too, and Windows
builds of e2fsprogs are only supported through MinGW anyway.

So I'd say that unix_io_manager is misleadingly named and really is more like
"regular_io_manager"...

I'm having a hard time seeing what the windows_io_manager gives us for the price
of duplicating lots of code, such as the I/O cache, from unix_io.c.

The only *potential* benefits of windows_io_manager I can see are the following:

  * Its ext2fs_file_open() always uses O_BINARY.  This seems to be a bug fix.

    However, unix_io.c could trivially do this.

  * windows_io_manager considers a path with one leading backslash to be an NT
    namespace path, for example \Device\HarddiskVolume4.  It uses
    DefineDosDevice() to create an alias for it and access it.  Perhaps the
    intent here was to add support for Windows volumes.

    However, this doesn't actually make sense, and IMO it is a bug, not a
    feature.  Paths need to be accepted in a consistent format.  It should just
    use the normal path format that Windows programs use (Win32 namespace).
    Windows volumes can still be specified using paths like \\?\D: or
    \\?\GLOBALROOT\Device\HarddiskVolume4.  (BTW, mke2fs doesn't actually work
    on volumes regardless of any of this, since check_plausibility() fails.)

  * windows_io_manager uses 'FILE_FLAG_NO_BUFFERING | FILE_FLAG_WRITE_THROUGH',
    which is the equivalent of O_DIRECT.  However, it is broken since it does
    this regardless of IO_FLAG_DIRECT_IO, and it also doesn't honor the
    alignment restrictions.  Note: e2fsprogs doesn't use direct I/O by default
    anyway, so direct I/O support doesn't seem like an important feature here.

Would you or anyone else have any objection if I just removed windows_io.c and
made Windows use unix_io.c again, with the O_BINARY fix as that seems to have
been the only real issue with it?

- Eric
