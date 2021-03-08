Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74548331976
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Mar 2021 22:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbhCHVlK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Mar 2021 16:41:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55442 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229650AbhCHVkx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Mar 2021 16:40:53 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 128Lenn1017234
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 Mar 2021 16:40:49 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0BCE615C3AAC; Mon,  8 Mar 2021 16:40:49 -0500 (EST)
Date:   Mon, 8 Mar 2021 16:40:49 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     George Goffe <grgoffe@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Scrubbing filenames from meta-data dump of ext4 filesystems
Message-ID: <YEaZ4RL3ZfXB8jdw@mit.edu>
References: <CALCFxS7EwQbF47GNgaiuOVrw0n=OQBzHTH6JpoeiZ=tb1CYB1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCFxS7EwQbF47GNgaiuOVrw0n=OQBzHTH6JpoeiZ=tb1CYB1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 08, 2021 at 12:01:46PM -0800, George Goffe wrote:
> Howdy,
> 
> I'm helping to shoot a bug on a Fedora Core 35 system and have been
> requested to provide a meta-data dump of the problem filesystem. The
> filenames are restricted so I need to scrub this file  before sending
> it.
> 
> Does ext4 have a facility whereby I can scrub the filenames from the dump?

Yes, please see the following excerpt from the e2image man page:

    This will only send the metadata information, without any data
    blocks.  However, the filenames in the directory blocks can still
    reveal information about the contents of the filesystem that the
    bug reporter may wish to keep confidential.  To address this
    concern, the -s option can be specified.  This will cause e2image
    to scramble directory entries and zero out any unused portions of
    the directory blocks before writing the image file.  However, the
    -s option will prevent analysis of problems related to hash-tree
    indexed directories.

The -s option can be used with the -r and -Q options to e2image, for
creating raw and qcow2 image dumps, respectively.  Because the
filenames have been scrambled, this will invalidate the hash-tree
indexes for the directory, so e2fsck will complain about this.  But
for some kinds of corruption, the -s option can provide data when the
customer would otherwise not be willing to provide a metadata-only
dump of the file system.

Hope this helps,

				- Ted
