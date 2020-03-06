Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AF717C006
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 15:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFOP1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Mar 2020 09:15:27 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37369 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726368AbgCFOP1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Mar 2020 09:15:27 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 026EFN8K004649
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Mar 2020 09:15:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1762942045B; Fri,  6 Mar 2020 09:15:23 -0500 (EST)
Date:   Fri, 6 Mar 2020 09:15:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Alok Jain <jain.alok103@gmail.com>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: Ext4 errors in linux /var/log/messages
Message-ID: <20200306141523.GA121760@mit.edu>
References: <CAG-6nk-Z7vsfa7fdpCfRAHQYvV+8jCRqAz7TBC-0LNi9qdPrwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG-6nk-Z7vsfa7fdpCfRAHQYvV+8jCRqAz7TBC-0LNi9qdPrwQ@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Mar 06, 2020 at 07:29:22PM +0530, Alok Jain wrote:
> Hi Guys,
> 
> Thanks for providing the forum to check the issue, I already got
> really helpful responses and need one more help wrt to EXT4 log
> messages coming in /var/log/messages file
> 
> 1) I have iSCSI device attached to my VM
> 2) Copied and extracted files in the attached device
> 3) Unmount and disconnected the device, post disconnect operation I
> can see lots of EXT4 file system errors in /var/log/messages file,
> attaching the same (err.txt) for review.
> 
> I am not sure what these log messages are correspond to as the device
> was already disconnected at  Feb I1:22:42, but th*e ext4 log messages
> came after that, can you please review and share your findings.

There's nothing really deep here.  Ext4 wasn't able to write to
/dev/sdd1.  Assuming that /dev/sdd is your iSCSI device, it's probably
because the connection to the iSCSI device had gotten disrupted.  This
is similar to what you might see if you were writing to a USB
thumbstick and the USB device is unceremoniously yanked out.

One possible scenario is thar while the umount was *started*, but it
had not completed writing out dirty blocks before the iSCSI device was
disconnected.  If that's true, this would be a case of operator error.

	       	  	       	    	  - Ted
