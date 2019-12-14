Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 295E111F4F4
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Dec 2019 23:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfLNWxg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Dec 2019 17:53:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42364 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbfLNWxg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Dec 2019 17:53:36 -0500
Received: from callcc.thunk.org (ec2-3-216-189-230.compute-1.amazonaws.com [3.216.189.230])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBEMrNf4027489
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Dec 2019 17:53:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 27BAD4207DF; Sat, 14 Dec 2019 17:53:21 -0500 (EST)
Date:   Sat, 14 Dec 2019 17:53:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yangerkun <yangerkun@huawei.com>, linux-ext4@vger.kernel.org,
        yi.zhang@huawei.com, houtao1@huawei.com
Subject: Re: [PATCH] ext4: reserve revoke credits in __ext4_new_inode
Message-ID: <20191214225321.GB448096@mit.edu>
References: <20191213014900.47228-1-yangerkun@huawei.com>
 <20191213093746.GA15331@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213093746.GA15331@quack2.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 13, 2019 at 10:37:46AM +0100, Jan Kara wrote:
> On Fri 13-12-19 09:49:00, yangerkun wrote:
> > It's possible that __ext4_new_inode will release the xattr block, so
> > it will trigger a warning since there is revoke credits will be 0 if
> > the handle == NULL. The below scripts can reproduce it easily.

Thanks, applied.

					- Ted
