Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5902529D2BB
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Oct 2020 22:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgJ1VeZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Oct 2020 17:34:25 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56724 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726557AbgJ1VeX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Oct 2020 17:34:23 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09SFTUUZ013074
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Oct 2020 11:29:31 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 92AB1420107; Wed, 28 Oct 2020 11:29:30 -0400 (EDT)
Date:   Wed, 28 Oct 2020 11:29:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: properly check for dirty state in
 ext4_inode_datasync_dirty()
Message-ID: <20201028152930.GQ5691@mit.edu>
References: <20201024140115.GA35973@xps-13-7390>
 <CAD+ocby3hA0GCm5Rf6T3UF+2UWgWoUjrz7=VzbeUMjX6Qx8D5g@mail.gmail.com>
 <da6697a0-4a23-ee68-fa2e-121b3d23c972@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da6697a0-4a23-ee68-fa2e-121b3d23c972@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 28, 2020 at 08:57:03AM +0530, Ritesh Harjani wrote:
> 
> Well, I too noticed this yesterday while I was testing xfstests -g swap.
> Those tests were returning _notrun, hence that could be the reason why
> it didn't get notice in XFSTESTing from Ted.

Yeah, one of the things I discussed with Harshad is we really need a
test that looks like generic/472, but which is in shared/NNN, and
which unconditionally tries to use swapon for those file systems where
swapfiles are expected to work.  This is actually the second
regression caused by our breaking swapfile support (the other being
the iomap bmap change), which escaped our testing because we didn't
notice that generic/472 was skipped.

(Mental note; perhaps we should have a way of flagging tests that are
skipped when previously they would run in the {kvm,gce}-xfstests
framework.)

						- Ted
