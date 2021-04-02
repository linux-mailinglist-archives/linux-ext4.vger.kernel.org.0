Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F244C353006
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 21:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbhDBT5j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 15:57:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53391 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229647AbhDBT5i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 15:57:38 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 132JvQB6026417
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Apr 2021 15:57:26 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2D69115C3ACE; Fri,  2 Apr 2021 15:57:26 -0400 (EDT)
Date:   Fri, 2 Apr 2021 15:57:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        linux-ext4@vger.kernel.org,
        harshad shirwadkar <harshadshirwadkar@gmail.com>,
        linfeilong <linfeilong@huawei.com>,
        lihaotian <lihaotian9@huawei.com>
Subject: Re: [PATCH] misc: remove useless code in set_inode_xattr()
Message-ID: <YGd3JmrmFtAHrWE4@mit.edu>
References: <283210da-b281-2dd7-6ef7-b31e81e72e01@huawei.com>
 <0949867f-5ed8-6a51-1b8e-b116b833ef22@huawei.com>
 <F8991EA4-20AB-4785-83A6-8BC159EF3970@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F8991EA4-20AB-4785-83A6-8BC159EF3970@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Mar 03, 2021 at 01:20:33PM -0700, Andreas Dilger wrote:
> On 2021/2/26 9:22, Zhiqiang Liu wrote:
> > 
> > In set_inode_xattr(), there are two returns as follows,
> > -
> >  return retval;
> >  return 0;
> > -
> > Here, we remove useless 'return 0;' code.
> > 
> > Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
