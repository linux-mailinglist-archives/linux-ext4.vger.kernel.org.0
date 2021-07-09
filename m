Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1342A3C2A83
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jul 2021 22:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbhGIUsI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Jul 2021 16:48:08 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:18634 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhGIUsH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Jul 2021 16:48:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1625863524; x=1657399524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5jYxzqwh/afUexbLAmNKPVpRdm0/qxTd9IFC6sVflLk=;
  b=qjLm37CGL3N0/zraoeRKbwgJLnZRGiMlU7qG3R1xx1vpNkGktGb7hc9w
   /GI8QCs1WD+pqQ53Q6sPp37zMgh6sk7PhZv1Yrm5GWFeoWrJsDasH9zxP
   Fj82wW34d9wIrtckid26twPHGSIFZQntI2F/5mqIRdqUJD8ctC07r1/Lu
   Q=;
X-IronPort-AV: E=Sophos;i="5.84,227,1620691200"; 
   d="scan'208";a="135471522"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-2c-76e0922c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 09 Jul 2021 20:45:24 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-76e0922c.us-west-2.amazon.com (Postfix) with ESMTPS id 8305AE255D;
        Fri,  9 Jul 2021 20:45:22 +0000 (UTC)
Received: from EX13D01UWA002.ant.amazon.com (10.43.160.74) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.18; Fri, 9 Jul 2021 20:45:22 +0000
Received: from localhost (10.43.160.41) by EX13d01UWA002.ant.amazon.com
 (10.43.160.74) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 9 Jul
 2021 20:45:21 +0000
Date:   Fri, 9 Jul 2021 13:45:21 -0700
From:   Samuel Mendoza-Jonas <samjonas@amazon.com>
To:     Changheun Lee <nanich.lee@samsung.com>
CC:     <alex_y_xu@yahoo.ca>, <gmazyland@gmail.com>, <bvanassche@acm.org>,
        <tytso@mit.edu>, <axboe@kernel.dk>, <bgoncalv@redhat.com>,
        <dm-crypt@saout.de>, <hch@lst.de>, <jaegeuk@kernel.org>,
        <linux-block@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <ming.lei@redhat.com>, <yi.zhang@redhat.com>, <dm-devel@redhat.com>
Subject: Re: regression: data corruption with ext4 on LUKS on nvme with
 torvalds master
Message-ID: <20210709204521.y3mg7wpejqctpkmi@u87e72aa3c6c25c.ant.amazon.com>
References: <alpine.LRH.2.02.2105140544010.22439@file01.intranet.prod.int.rdu2.redhat.com>
 <CGME20210514104426epcas1p3ee2f22f8e18c961118795c356e6a14ae@epcas1p3.samsung.com>
 <20210514102614.3804-1-nanich.lee@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210514102614.3804-1-nanich.lee@samsung.com>
User-Agent: NeoMutt/20171215
X-Originating-IP: [10.43.160.41]
X-ClientProxiedBy: EX13D43UWC004.ant.amazon.com (10.43.162.42) To
 EX13d01UWA002.ant.amazon.com (10.43.160.74)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 14, 2021 at 07:26:14PM +0900, Changheun Lee wrote:
> > On 5/13/21 7:15 AM, Theodore Ts'o wrote:
> > > On Thu, May 13, 2021 at 06:42:22PM +0900, Changheun Lee wrote:
> > >>
> > >> Problem might be casued by exhausting of memory. And memory exhausting
> > >> would be caused by setting of small bio_max_size. Actually it was not
> > >> reproduced in my VM environment at first. But, I reproduced same problem
> > >> when bio_max_size is set with 8KB forced. Too many bio allocation would
> > >> be occurred by setting of 8KB bio_max_size.
> > > 
> > > Hmm... I'm not sure how to align your diagnosis with the symptoms in
> > > the bug report.  If we were limited by memory, that should slow down
> > > the I/O, but we should still be making forward progress, no?  And a
> > > forced reboot should not result in data corruption, unless maybe there
> > 
> > If you use data=writeback, data writes and journal writes are not 
> > synchronized. So, it may be possible that a journal write made it through, 
> > a data write didn't - the end result would be a file containing random 
> > contents that was on the disk.
> > 
> > Changheun - do you use data=writeback? Did the corruption happen only in 
> > newly created files? Or did it corrupt existing files?
> 
> Actually I didn't reproduced data corruption. I only reproduced hang during
> making ext4 filesystem. Alex, could you check it?
> 
> > 
> > > was a missing check for a failed memory allocation, causing data to be
> > > written to the wrong location, a missing error check leading to the
> > > block or file system layer not noticing that a write had failed
> > > (although again, memory exhaustion should not lead to failed writes;
> > > it might slow us down, sure, but if writes are being failed, something
> > > is Badly Going Wrong --- things like writes to the swap device or
> > > writes by the page cleaner must succeed, or else Things Would Go Bad
> > > In A Hurry).
> > 
> > Mikulas

I've recently been debugging an issue that isn't this exact issue
(it occurs in 5.10), but looks somewhat similar.
On a host that
- Is running a kernel 5.4 >= x >= 5.10.47 at least
- Using an EXT4 + LUKS partition
- Running Elasticsearch stress tests

We see that the index files used by the Elasticsearch process become
corrupt after some time, and in each case I've seen so far the content
of the file looks like the EXT4 extent header. 
	#define EXT4_EXT_MAGIC          cpu_to_le16(0xf30a)

For example:
$ hexdump -C /hdd1/nodes/0/indices/c6eSGDlCRjaWeIBwdeo9DQ/0/index/_23c.si
00000000  0a f3 04 00 54 01 00 00  00 00 00 00 00 00 00 00  |....T...........|
00000010  00 38 00 00 00 60 46 05  00 38 00 00 00 88 00 00  |.8...`F..8......|
00000020  00 98 46 05 00 40 00 00  00 88 00 00 00 a0 46 05  |..F..@........F.|
00000030  00 48 00 00 00 88 00 00  00 a8 46 05 00 48 00 00  |.H........F..H..|
00000040  00 88 00 00 00 a8 46 05  00 48 00 00 00 88 00 00  |......F..H......|
00000050  00 a8 46 05 00 48 00 00  00 88 00 00 00 a8 46 05  |..F..H........F.|
00000060  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001a0  00 00                                             |..|
000001a2


I'm working on tracing exactly when this happens, but I'd be interested
to hear if that sounds familar or might have a similar underlying cause
beyond the commit that was reverted above.

Cheers,
Sam Mendoza-Jonas
