Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7F6162AFE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 17:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgBRQrT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 11:47:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55451 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726399AbgBRQrT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 11:47:19 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01IGkuZ2010472
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 11:46:57 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E4C624211EF; Tue, 18 Feb 2020 11:46:55 -0500 (EST)
Date:   Tue, 18 Feb 2020 11:46:55 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, jack@suse.cz,
        linux-ext4@vger.kernel.org, luoshijie1@huawei.com,
        zhangxiaoxu5@huawei.com
Subject: Re: [PATCH v3 2/2] jbd2: do not clear the BH_Mapped flag when
 forgetting a metadata buffer
Message-ID: <20200218164655.GB147128@mit.edu>
References: <20200213063821.30455-1-yi.zhang@huawei.com>
 <20200213063821.30455-3-yi.zhang@huawei.com>
 <20200218051814.854505204E@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218051814.854505204E@d06av21.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Feb 18, 2020 at 10:48:13AM +0530, Ritesh Harjani wrote:
> > Fixes: 904cdbd41d74 ("jbd2: clear dirty flag when revoking a buffer from an older transaction")
> > Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> This should be a stable candidate I guess.

I took care of that before sending a pull request to Linus.  :-)

       	       	    	   	   - Ted
