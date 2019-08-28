Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00271A0664
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Aug 2019 17:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfH1PdL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Aug 2019 11:33:11 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35857 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbfH1PdL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Aug 2019 11:33:11 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7SFX2jU013914
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Aug 2019 11:33:03 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A474442049E; Wed, 28 Aug 2019 11:33:01 -0400 (EDT)
Date:   Wed, 28 Aug 2019 11:33:01 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: tidy up white space in count_rsvd()
Message-ID: <20190828153301.GI24857@mit.edu>
References: <20190827084725.GA22301@mwanda>
 <20190827205445.3gtjyktwitgnbzx4@rocky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827205445.3gtjyktwitgnbzx4@rocky>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 27, 2019 at 04:54:45PM -0400, Eric Whitney wrote:
> * Dan Carpenter <dan.carpenter@oracle.com>:
> > This line was indented one tab too far.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Good catch, thanks.  You can add:
> 
> Reviewed-by: Eric Whitney <enwlinux@gmail.com>

Thanks, applied by fixing up the original base patch.

		   	     	 - Ted
