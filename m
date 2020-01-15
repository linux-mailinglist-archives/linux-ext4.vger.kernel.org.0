Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF8A213C9F1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Jan 2020 17:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAOQso (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Jan 2020 11:48:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53502 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728896AbgAOQsn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Jan 2020 11:48:43 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00FGmT0f023135
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 11:48:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0B1E04207DF; Wed, 15 Jan 2020 11:48:29 -0500 (EST)
Date:   Wed, 15 Jan 2020 11:48:29 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: Discussion: is it time to remove dioread_nolock?
Message-ID: <20200115164829.GB165687@mit.edu>
References: <20200109163802.GA33929@mit.edu>
 <20200114233054.890D7A4040@d06av23.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114233054.890D7A4040@d06av23.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 15, 2020 at 05:00:53AM +0530, Ritesh Harjani wrote:
> 
> I too collected some performance numbers on my x86 box with
> --direct=1, bs=4K/1M & ioengine=libaio, with default opt v/s dioread_nolock
> opt on latest ext4 git tree.
> 
> I found the delta to be within +/- 6% in all of the runs which includes, seq
> read, mixed rw & mixed randrw.

Thanks for taking the performance measurements!

Are you able to release more detail of what the deltas were for those
tests?  And how stable were those results across repeated runs?

Thanks,

					- Ted
