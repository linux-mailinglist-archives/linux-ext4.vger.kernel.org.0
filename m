Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E915A10422
	for <lists+linux-ext4@lfdr.de>; Wed,  1 May 2019 05:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbfEADLi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Apr 2019 23:11:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59654 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725799AbfEADLi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 30 Apr 2019 23:11:38 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x413BQ8T005302
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Apr 2019 23:11:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AA396420023; Tue, 30 Apr 2019 23:11:25 -0400 (EDT)
Date:   Tue, 30 Apr 2019 23:11:25 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Debabrata Banerjee <dbanerje@akamai.com>
Cc:     Jan Kara <jack@suse.cz>, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: bad mount opts in no journal mode
Message-ID: <20190501031125.GC5377@mit.edu>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
        Debabrata Banerjee <dbanerje@akamai.com>, Jan Kara <jack@suse.cz>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org
References: <20190429173158.1463-1-dbanerje@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429173158.1463-1-dbanerje@akamai.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 29, 2019 at 01:31:58PM -0400, Debabrata Banerjee wrote:
> Fixes:
> commit 1e381f60dad9 ("ext4: do not allow journal_opts for fs w/o journal")
> 
> Instead of removing EXT4_MOUNT_JOURNAL_CHECKSUM from s_def_mount_opt as
> I assume was intended, all other options were blown away leading to
> _ext4_show_options() output being incorrect.
> 
> Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>

Thanks, applied.  Note that the Fixes line should like this:

Fixes: 1e381f60dad9 ("ext4: do not allow journal_opts for fs w/o journal")

... and be placed along with the Signed-off-by: headers.

    	   	  	     	 		- Ted
