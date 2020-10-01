Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DCC2808DB
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 22:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgJAU45 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 16:56:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40337 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726515AbgJAU45 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 16:56:57 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091KuhHO027258
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 16:56:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 16AEA42003C; Thu,  1 Oct 2020 16:56:43 -0400 (EDT)
Date:   Thu, 1 Oct 2020 16:56:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Xiao Yang <yangx.jy@cn.fujitsu.com>
Cc:     darrick.wong@oracle.com, ira.weiny@intel.com, ebiggers@kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] chattr/lsattr: Support dax attribute
Message-ID: <20201001205643.GA656789@mit.edu>
References: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728053321.12892-1-yangx.jy@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 28, 2020 at 01:33:21PM +0800, Xiao Yang wrote:
> Use the letter 'x' to set/get dax attribute on a directory/file.
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.  Apologies for the delay.

		  	    	    - Ted
