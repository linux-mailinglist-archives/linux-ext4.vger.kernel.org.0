Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01A936965B
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Apr 2021 17:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242829AbhDWPrH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Apr 2021 11:47:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54178 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230294AbhDWPrF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Apr 2021 11:47:05 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13NFkCke029158
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Apr 2021 11:46:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CCDFB15C3B0D; Fri, 23 Apr 2021 11:46:12 -0400 (EDT)
Date:   Fri, 23 Apr 2021 11:46:12 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>
Cc:     Haotian Li <lihaotian9@huawei.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "harshad shirwadkar," <harshadshirwadkar@gmail.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] e2fsprogs: Try again to solve unreliable io case
Message-ID: <YILrxJoOA1reNhMq@mit.edu>
References: <d4fd737d-4280-1aee-32ae-36b303e6644d@huawei.com>
 <YH7/D1h5r9WB1TNq@mit.edu>
 <c1eb6441-9081-530c-63d8-1987048b2011@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1eb6441-9081-530c-63d8-1987048b2011@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 23, 2021 at 10:18:09AM +0800, Zhiqiang Liu wrote:
> Thanks for your reply.
> Actually, we have met the problem in ipsan situation.
> When exec 'fsck -a <remote-device>', short-term fluctuations or
> abnormalities may occur on the network. Despite the driver has
> do the best effort, some IO errors may occur. So add retrying in
> e2fsprogs can further improve the reliability of the repair
> process.

But why doesn't this happen when the file system is mounted, and why
is that acceptable?   And why not change the driver to do more retries?

   		      	      	  - Ted
