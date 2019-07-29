Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D360978C14
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2019 14:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfG2MzQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jul 2019 08:55:16 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58323 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727908AbfG2MzP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 29 Jul 2019 08:55:15 -0400
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6TCt6lh012774
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 08:55:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 40AFE4202F5; Mon, 29 Jul 2019 08:55:05 -0400 (EDT)
Date:   Mon, 29 Jul 2019 08:55:05 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dmitrij Gusev <dmitrij@gusev.co>
Cc:     "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>
Subject: Re: ext4 file system is constantly writing to the block device with
 no activity from the applications, is it a bug?
Message-ID: <20190729125505.GA10639@mit.edu>
References: <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
 <20190711171046.GA13966@mit.edu>
 <20190712191903.GP2772@twosigma.com>
 <20190712202827.GA16730@mit.edu>
 <7cc876ae264c495e9868717f33a63a77@EXMBDFT10.ad.twosigma.com>
 <865a6dad983e4dedb9836075c210a782@EXMBDFT11.ad.twosigma.com>
 <20190729100914.GB17833@quack2.suse.cz>
 <b19e976b-097e-0b94-23c3-e0f27a97a64c@gusev.co>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b19e976b-097e-0b94-23c3-e0f27a97a64c@gusev.co>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 29, 2019 at 02:18:22PM +0300, Dmitrij Gusev wrote:
> 
> A ext4 file system is constantly writing to the block device with no
> activity from the applications, is it a bug?
> 
> Write speed is about 64k bytes (almost always exactly 64k bytes) per second
> every 1-2 seconds (I've discovered it after a RAID sync finished). Please
> the check activity log sample below.

Is this a freshly created file system?  It could be the lazy inode
table initialization.  You can suppress it using "mount -o
noinit_itable", but it will leave portions of the inode table
unzeroed, which can lead to confusion if the system crashes and e2fsck
has to try to recover the file system.

Or you can not enable lazy inode table initialization when the file
system is created, using "mke2fs -t ext4 -E lazy_itable_init=0
/dev/XXX".  (See the manual page for mke2fs.conf for another way to
turn it off by default.)

Turning off lazy inode table initialization mke2fs to take **much**
longer, especially on large RAID arrays.  The idea is to trade off
mkfs time with background activity to initialize the inode table when
the file system is mounted.  The noinit_itable mount option was added
so that a distro installer can temporarily suppress the background
inode table initialization to speed up the install; but then when the
system is booted, it can run in the background later.


If that's not it, try installing the blktrace package and then run
"btrace /dev/<vg>/home", and see what it reports.  For example, here's
the output from running "touch /mnt/test" (comments prefixed by '#'):

# here's the touch process reading the inode...
259,0    2        1    37.115679608  6646  Q  RM 4232 + 8 [touch]
259,0    2        2    37.115682891  6646  C  RM 4232 + 8 [0]
# here's the journal commit, 5 seconds later
259,0    1       11    42.543705759  6570  Q  WS 3932216 + 8 [jbd2/pmem0-8]
259,0    1       12    42.543709184  6570  C  WS 3932216 + 8 [0]
259,0    1       13    42.543713049  6570  Q  WS 3932224 + 8 [jbd2/pmem0-8]
259,0    1       14    42.543714248  6570  C  WS 3932224 + 8 [0]
259,0    1       15    42.543717049  6570  Q  WS 3932232 + 8 [jbd2/pmem0-8]
259,0    1       16    42.543718193  6570  C  WS 3932232 + 8 [0]
259,0    1       17    42.543720895  6570  Q  WS 3932240 + 8 [jbd2/pmem0-8]
259,0    1       18    42.543722028  6570  C  WS 3932240 + 8 [0]
259,0    1       19    42.543724806  6570  Q  WS 3932248 + 8 [jbd2/pmem0-8]
259,0    1       20    42.543725952  6570  C  WS 3932248 + 8 [0]
259,0    1       21    42.543728697  6570  Q  WS 3932256 + 8 [jbd2/pmem0-8]
259,0    1       22    42.543729799  6570  C  WS 3932256 + 8 [0]
259,0    1       23    42.543745380  6570  Q FWFS 3932264 + 8 [jbd2/pmem0-8]
259,0    1       24    42.543746836  6570  C FWFS 3932264 + 8 [0]
# and here's the writeback to the inode table and superblock,
# 30 seconds later
259,0    1       25    72.836967205    91  Q   W 0 + 8 [kworker/u8:3]
259,0    1       26    72.836970861    91  C   W 0 + 8 [0]
259,0    1       27    72.836984218    91  Q  WM 8 + 8 [kworker/u8:3]
259,0    1       28    72.836985929    91  C  WM 8 + 8 [0]
259,0    1       29    72.836992108    91  Q  WM 4232 + 8 [kworker/u8:3]
259,0    1       30    72.836993953    91  C  WM 4232 + 8 [0]
259,0    1       31    72.837001370    91  Q  WM 4360 + 8 [kworker/u8:3]
259,0    1       32    72.837003210    91  C  WM 4360 + 8 [0]
259,0    1       33    72.837010993    91  Q  WM 69896 + 8 [kworker/u8:3]
259,0    1       34    72.837012564    91  C  WM 69896 + 8 [0]

Cheers,

						- Ted
