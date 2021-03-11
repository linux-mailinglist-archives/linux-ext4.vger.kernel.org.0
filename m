Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E102A337879
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Mar 2021 16:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234267AbhCKPui (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 10:50:38 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53403 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234241AbhCKPuZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Mar 2021 10:50:25 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 12BFo363008201
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 10:50:04 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 61A8D15C3AA0; Thu, 11 Mar 2021 10:50:03 -0500 (EST)
Date:   Thu, 11 Mar 2021 10:50:03 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] ext4: do not try to set xattr into ea_inode if value is
 empty
Message-ID: <YEo8K+U0wsB8BXEB@mit.edu>
References: <20210305120508.298465-1-yi.zhang@huawei.com>
 <YEo7nEuVpqLmIeLz@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEo7nEuVpqLmIeLz@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 11, 2021 at 10:47:40AM -0500, Theodore Ts'o wrote:
> On Fri, Mar 05, 2021 at 08:05:08PM +0800, zhangyi (F) wrote:
> > Syzbot report a warning that ext4 may create an empty ea_inode if set
> > an empty extent attribute to a file on the file system which is no free
> > blocks left.
> 
> I'll apply this, but can you tell us which syzbot warning this
> addresses so we can mark the commit appropriately?

Never mind, I missed the Reported-by: which identified the syzbot report.

      	      	     	 	      - Ted
