Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D13C1A3EA8
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Apr 2020 05:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgDJDRy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Apr 2020 23:17:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55472 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726598AbgDJDRy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Apr 2020 23:17:54 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 03A3HROM029851
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Apr 2020 23:17:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F21C842013D; Thu,  9 Apr 2020 23:17:26 -0400 (EDT)
Date:   Thu, 9 Apr 2020 23:17:26 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: using matching invalidatepage in ext4_writepage
Message-ID: <20200410031726.GH45598@mit.edu>
References: <20200226041002.13914-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226041002.13914-1-yangerkun@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 26, 2020 at 12:10:02PM +0800, yangerkun wrote:
> Run generic/388 with journal data mode sometimes may trigger the warning
> in ext4_invalidatepage. Actually, we should use the matching invalidatepage
> in ext4_writepage.
> 
> Signed-off-by: yangerkun <yangerkun@huawei.com>

Applied, thanks.  Apologies for overlooking this patch earlier.

	 	  	    		    	 - Ted
