Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD0B532829D
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 16:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhCAPfi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 10:35:38 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33716 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S237285AbhCAPfN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 10:35:13 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 121FYNo7019654
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 1 Mar 2021 10:34:23 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E81A515C3A88; Mon,  1 Mar 2021 10:34:22 -0500 (EST)
Date:   Mon, 1 Mar 2021 10:34:22 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: badblocks from e2fsprogs
Message-ID: <YD0JfjnMtXzGguZ6@mit.edu>
References: <CA+icZUXzjAniVZMzS5ePNa6HrjWL6ZrpAgzWufy74zHSyN+urQ@mail.gmail.com>
 <YD0DaqIbAf0T2tw2@mit.edu>
 <CA+icZUXJpEEO4GS1fy9ANXCXJ2BtD_rd1tAtXLun++i0taZwSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUXJpEEO4GS1fy9ANXCXJ2BtD_rd1tAtXLun++i0taZwSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 01, 2021 at 04:12:03PM +0100, Sedat Dilek wrote:
> 
> OK, I see.
> So I misunderstood the -o option.

It was clearly documented in the man page:

       -o output_file
              Write the list of bad blocks to the specified file.
              Without this option, badblocks displays the list on
              its standard output.  The format of this file is
              suitable for use by the -l option in e2fsck(8) or
              mke2fs(8).

I will say that for modern disks, the usefulness of badblocks has
decreased significantly over time.  That's because for modern-sized
disks, it can often take more than 24 hours to do a full read on the
entire disk surface --- and the factory testing done by HDD
manufacturers is far more comprehensive.

In addition, SMART (see the smartctl package) is a much more reliable
and efficient way of judging disk health.

The badblocks program was written over two decades ago, before the
days of SATA, and even IDE disks, when disk controlls and HDD's were
far more primitive.  These days, modern HDD and SSD will do their own
bad block redirection from a built-in bad block sparing pool, and the
usefulness of using badblocks has been significantly decreased.

Regards,

						- Ted
