Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71A8812ADA3
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 18:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfLZRRq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 12:17:46 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57774 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbfLZRRq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 12:17:46 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBQHHWX5016268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Dec 2019 12:17:33 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B3B6E420485; Thu, 26 Dec 2019 12:17:31 -0500 (EST)
Date:   Thu, 26 Dec 2019 12:17:31 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Berrocal, Eduardo" <eduardo.berrocal@intel.com>
Subject: Re: [PATCH] ext4: Optimize ext4 DIO overwrites
Message-ID: <20191226171731.GE3158@mit.edu>
References: <20191218174433.19380-1-jack@suse.cz>
 <20191219135329.529E3A404D@d06av23.portsmouth.uk.ibm.com>
 <20191219192823.GA5389@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191219192823.GA5389@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 19, 2019 at 08:28:23PM +0100, Jan Kara wrote:
> > However depending on which patch lands first one may need a
> > re-basing. Will conflict with this-
> > https://marc.info/?l=linux-ext4&m=157613016931238&w=2
> 
> Yes, but the conflict is minor and trivial to resolve.
> 

Is this the correct resolution?

--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -447,6 +447,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
 	size_t count = iov_iter_count(from);
+	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
 	bool extend = false, unaligned_io = false;
 	bool ilock_shared = true;
 
@@ -526,7 +527,9 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		ext4_journal_stop(handle);
 	}
 
-	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
+	if (ilock_shared)
+		iomap_ops = &ext4_iomap_overwrite_ops;
+	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
 			   is_sync_kiocb(iocb) || unaligned_io || extend);
 
 	if (extend)

     	   	    	      	  - Ted
				  
