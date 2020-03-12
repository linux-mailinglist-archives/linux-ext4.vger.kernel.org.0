Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8856183C49
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Mar 2020 23:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCLWUu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Mar 2020 18:20:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbgCLWUu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Mar 2020 18:20:50 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E90D20637;
        Thu, 12 Mar 2020 22:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584051649;
        bh=AO36XPdzn8T0byP4kCHnxpBmX1FVVp3X2e6l2JfIBzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHkYDUfdELnxjoFUBM64ZraMawOd1uC1bD/o1kAQ8yN2zjBTE5PlW+Vz8CskI+FTf
         j3puzuM4kZt9fhbIbdjbKXtb5vFOBsWNHolMctmFvnuTCLoZWzS3Tmss1NJETSDdSt
         WSheqxk4nT5HiGvmENJp3tRZbt2lWiF3fsJaHDOY=
Date:   Thu, 12 Mar 2020 15:20:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] xfs: clear PF_MEMALLOC before exiting xfsaild thread
Message-ID: <20200312222042.GA816@sol.localdomain>
References: <20200309010410.GA371527@sol.localdomain>
 <20200309043430.143206-1-ebiggers@kernel.org>
 <20200309162439.GB8045@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309162439.GB8045@magnolia>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 09, 2020 at 09:24:39AM -0700, Darrick J. Wong wrote:
> > 
> > 	mkfs.ext2 -F /dev/vdb
> > 	mount /vdb -t ext4
> > 	touch /vdb/file
> > 	chattr +S /vdb/file
> 
> Does this trip if the process accounting file is also on an xfs
> filesystem?
> 
> > 	accton /vdb/file
> > 	mkfs.xfs -f /dev/vdc
> > 	mount /vdc
> > 	umount /vdc
> 
> ...and if so, can this be turned into an fstests case, please?
> 

Test sent out at
https://lkml.kernel.org/fstests/20200312221437.141484-1-ebiggers@kernel.org/

- Eric
