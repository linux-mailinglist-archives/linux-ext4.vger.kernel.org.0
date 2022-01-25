Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E467F49BCB5
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jan 2022 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiAYUJ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jan 2022 15:09:57 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59374 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231725AbiAYUJX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jan 2022 15:09:23 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20PK8xG3018303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 15:09:00 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 07F8A42011A; Tue, 25 Jan 2022 15:08:58 -0500 (EST)
Date:   Tue, 25 Jan 2022 15:08:58 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>,
        chenlong <chenlongcl.chen@huawei.com>
Subject: Re: [RFC 0/1] ext4/054: Should we remove auto and quick group?
Message-ID: <YfBY2pMmEFPb+qCF@mit.edu>
References: <cover.1643089143.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1643089143.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 25, 2022 at 11:32:01AM +0530, Ritesh Harjani wrote:
> Hello Zhang/Ted,
> 
> Looks like the issue fixed by patches at [1], were observed with fault injection
> testing and with errors=continue mount option. But were not cc'd to stable.
> 
> Do you think those should be cc'd to stable tree?

I already requested that they be backported, and they are in 5.10.89+
and 5.15.12+.  Unfortunately the patches don't backport cleanly into
5.4, and while I did the manual backport for 5.10, I haven't gotten
around to backporting them into 5.4 or older kernels.

       	  	      	   	       - Ted
