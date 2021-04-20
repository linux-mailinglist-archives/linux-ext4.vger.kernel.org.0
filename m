Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 598B2365D2A
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Apr 2021 18:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbhDTQUT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 20 Apr 2021 12:20:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51393 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232174AbhDTQUR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 20 Apr 2021 12:20:17 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 13KGJRcM002876
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 12:19:27 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0FA6615C3B0D; Tue, 20 Apr 2021 12:19:27 -0400 (EDT)
Date:   Tue, 20 Apr 2021 12:19:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Haotian Li <lihaotian9@huawei.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "harshad shirwadkar," <harshadshirwadkar@gmail.com>,
        "liuzhiqiang (I)" <liuzhiqiang26@huawei.com>,
        linfeilong <linfeilong@huawei.com>
Subject: Re: [PATCH] e2fsprogs: Try again to solve unreliable io case
Message-ID: <YH7/D1h5r9WB1TNq@mit.edu>
References: <d4fd737d-4280-1aee-32ae-36b303e6644d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4fd737d-4280-1aee-32ae-36b303e6644d@huawei.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 20, 2021 at 03:18:05PM +0800, Haotian Li wrote:
> If some I/O error occured during e2fsck, for example the
> fibre channel connections are flasky, the e2fsck may exit.
> Try again in these I/O error cases may help e2fsck
> successfully execute and fix the disk correctly.

Why not fix this by retrying in the device driver instead?  If the
Fibre Channel is that flaky, then it's going to be a problem when the
file system is mounted, so it would seem to me that fixing this in the
kernel makes a lot more sense.

    	   	       	    - Ted
