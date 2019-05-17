Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03E4121FE0
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 23:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfEQVuZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 17:50:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54842 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727530AbfEQVuZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 May 2019 17:50:25 -0400
Received: from callcc.thunk.org (75-104-86-155.mobility.exede.net [75.104.86.155] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4HLo4Gk009812
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 May 2019 17:50:18 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 76914420027; Fri, 17 May 2019 17:50:02 -0400 (EDT)
Date:   Fri, 17 May 2019 17:50:02 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid panic during forced reboot due to aborted
 journal
Message-ID: <20190517215002.GB21961@mit.edu>
References: <20190515104622.6793-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515104622.6793-1-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 15, 2019 at 12:46:22PM +0200, Jan Kara wrote:
> Handling of aborted journal is a special code path different from
> standard ext4_error() one and it can call panic() as well. Commit
> 1dc1097ff60e ("ext4: avoid panic during forced reboot") forgot to update
> this path so fix that omission.
> 
> Fixes: 1dc1097ff60e ("ext4: avoid panic during forced reboot")
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
