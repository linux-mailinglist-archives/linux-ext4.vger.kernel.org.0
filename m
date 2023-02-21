Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9302C69E51B
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 17:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjBUQtB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 11:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjBUQs6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 11:48:58 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D83B2CFD0
        for <linux-ext4@vger.kernel.org>; Tue, 21 Feb 2023 08:48:55 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31LGmoto004400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Feb 2023 11:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676998132; bh=MorhVzvmna/bJvz7Z6t55ud5mrq88Ew9dRM8kzb81tI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=lEOBLtFp+YFsmraZdC71nGf/pP2eunG0VM806HqtDJzFl6HL9fNvfe4zNM+9/nL+X
         sCS0zpovF5GQr+hgiiAzwfZCZ96czYphpSgKLwBmyEoKlYGW1BQqcBQGMDse7MCarX
         BAyLXZoNnClc9vQH7vHYdE5qz5Xan1g0ghF5dPgsqXEJVU8otBrR0af62gyGzRiVlT
         iRLb+lj7p3D5BZEGGLhYRZJ4NdzV3J+bVO31wpUeH/f3plpJSR7Goxe6qph/+XjCGz
         H7AquVZGdXLn4bpV+ueDc8PRnCw9TaSOIwOdj1z50aA8XdZJzoO2ZQpn1v9KlwGnvl
         QHx2yTdwFjYYw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9C42615C35A1; Tue, 21 Feb 2023 11:48:50 -0500 (EST)
Date:   Tue, 21 Feb 2023 11:48:50 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Etienne Schmidt OSS <Etienne.Schmidt-oss@weidmueller.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Bug: Buffer I/O error with an ext4 filesystem inside a file
Message-ID: <Y/T18ryXLqowKwaX@mit.edu>
References: <AM0PR08MB38573D4128D2EB770D79604AFAA59@AM0PR08MB3857.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR08MB38573D4128D2EB770D79604AFAA59@AM0PR08MB3857.eurprd08.prod.outlook.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 21, 2023 at 11:57:36AM +0000, Etienne Schmidt OSS wrote:
> Hello everyone!
> 
> I have tried to allocate disk space for a service. To do this I created a file with fixed disk usage and created an ext4 file system in it. When I mount this file the mount point should be reserved space but something went wrong. With full memory I get a buffer I/O error.
> 
> Steps to Reproduce
> ================
> The following steps reproduce these bug. I execute them as root user.
> 
> Preparation:
> 1.	Create a file with fix disk usage:
> 	`fallocate -l 32M /var/reserved.ext4`
> 2.	Create a ext4 filesystem inside it:
> 	`mkfs.ext4 /var/reserved.ext4`
> 3.	Create the mountpoint:
> 	`mkdir /var/reserved/`
> 4.	Mount the file:
> 	`mount /var/reserved.ext4 /var/reserved/`
> 5.	(Optional) Check the filesystem with fsck.
> 
> Now the reserved storage works fine!
> 
> The Bug:
> 1.	Fill up the underlying filesystem:
> 	`fallocate -l 100G /var/very_big_file`
> 2.	Write into the reserved storage:
> 	`echo "Test" > /var/reserved/test_file_1`
> 	or anything else.
> 3.	The file is written but the journal shows the following error:
> 
> 	```

Fallocate reserves the data blocks, but all of the extents are marked
as "uninitialized".  So when you write into /var/reserved.ext4, either
through the loop device or by directly writing into the file ---
especially if you are writing in a number of different locations in
the file, a large extent marked "uinitiailized" might need to be split
into 3 extents:

     |--------------------- uninitialized ----------------------------|
     
                  			becomes

     |---------- uninitialized --|--- written --|-- unitialized-------|


With enough writes, ext4 will need to allocate a block in the
underlying file system to expand the extent tree.  But since you've
filled up the underlying file system, there is no space for the
expanded extent tree, and so the attempted write by the loop device
fails:

> 	May 03 08:31:42 ucm kernel: loop: Write error at byte offset 8913920, length 1024.
> 	May 03 08:31:42 ucm kernel: blk_update_request: I/O error, dev loop0, sector 17410 op 0x1:(WRITE) flags 0x0 phys_seg 1 prio class 0

So there are a couple of different solutions to avoid this.

1) Force the entire /var/reserved.ext4 to be initialized, by using:

	dd if=/dev/zero of=/var/reserved.ext4 bs=1M count=32

... instead of using the fallocate command.

2) Don't fill the underlying file system.  "Doctor, doctor it hurts
when I do that!"  "Well, then don't do that!"

Best regards,

						- Ted
