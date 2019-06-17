Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB19484EF
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Jun 2019 16:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfFQOKI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Jun 2019 10:10:08 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59006 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725906AbfFQOKI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Jun 2019 10:10:08 -0400
Received: from callcc.thunk.org (rrcs-74-87-88-165.west.biz.rr.com [74.87.88.165])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x5HE9qft017594
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jun 2019 10:09:54 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 69A45420484; Mon, 17 Jun 2019 10:09:52 -0400 (EDT)
Date:   Mon, 17 Jun 2019 10:09:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhangjs Jinshui <leozhangjs@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, zachary@baishancloud.com
Subject: Re: [PATCH] ext4: make __ext4_get_inode_loc plug
Message-ID: <20190617140952.GF4358@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Zhangjs Jinshui <leozhangjs@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        zachary@baishancloud.com
References: <CAEKGrW601HBKVA+FsoeCPMXFZnzv8r0_96FaLDnVKCp=KmcvtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEKGrW601HBKVA+FsoeCPMXFZnzv8r0_96FaLDnVKCp=KmcvtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 17, 2019 at 03:11:21PM +0800, Zhangjs Jinshui wrote:
> If the task is unplugged when called, the inode_readahead_blks may not be
> merged,
> these will cause small pieces of io, It should be plugged.
> 
> Signed-off-by: zhangjs <zachary@baishancloud.com>

This patch is white space damaged.   Please see:

https://www.kernel.org/doc/html/latest/process/email-clients.html

for more information.  Could you resend using an appropriate mail
client?

Many thanks!

					- Ted
