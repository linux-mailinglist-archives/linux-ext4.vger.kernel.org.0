Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0902AD870
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Nov 2020 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKJOOm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Nov 2020 09:14:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38944 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726721AbgKJOOm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Nov 2020 09:14:42 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AAEEUTs000834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Nov 2020 09:14:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5C28D420107; Tue, 10 Nov 2020 09:14:30 -0500 (EST)
Date:   Tue, 10 Nov 2020 09:14:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Tristate moount option comatibility fixup
Message-ID: <20201110141430.GA2951190@mit.edu>
References: <cover.1604948373.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1604948373.git.msuchanek@suse.de>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 09, 2020 at 08:10:07PM +0100, Michal Suchanek wrote:
> Hello,
> 
> after the tristate dax option change some applications fail to detect
> pmem devices because the dax option no longer shows in mtab when device
> is mounted with -o dax.

Which applications?  Name them.

We *really* don't want to encourage applications to make decisions
only based on the mount options.  For example, it could be that the
application's files will have the S_DAX flag set.

It would be a real shame if we are actively encourage applications to
use a broken configuration mechanism which was only used as a hack
while DAX was in experimental status.

						- Ted
