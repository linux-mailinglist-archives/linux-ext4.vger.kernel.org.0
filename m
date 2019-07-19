Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED126EA73
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2019 20:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730354AbfGSSEX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jul 2019 14:04:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46175 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729769AbfGSSEX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Jul 2019 14:04:23 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6JI4Ic9012427
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Jul 2019 14:04:19 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4A231420054; Fri, 19 Jul 2019 14:04:18 -0400 (EDT)
Date:   Fri, 19 Jul 2019 14:04:18 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ian Malone <ibmalone@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: ext4 reserved blocks not enforced?
Message-ID: <20190719180418.GD19119@mit.edu>
References: <CAL3-7Mp_0=tMReTRGB0u0OxynKXjLkCkr1X7d-+JwhwZpVfvvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3-7Mp_0=tMReTRGB0u0OxynKXjLkCkr1X7d-+JwhwZpVfvvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 18, 2019 at 04:26:19PM +0100, Ian Malone wrote:
> Recently we extended a ~1.9TB filesystem by 20GB, however afterwards
> df reported 0 available bytes. The LV had been increased and running
> resize2fs reported that the fs was already the full size of the
> device. tune2fs showed fewer free blocks than reserved blocks. Despite
> this, normal users could create files on the filesystem (via nfs)

It's the "via NFS" which is the issue.  The problem is that model with
NFS is that access checks are done on the client side, and the NFS
client doesn't know about ext4's reserved block policy (nor does the
NFS client have a good way of knowing how blocks are reserved, or,
without constantly requesting the free space via repeated NFS queries,
how many free blocks are availble on the server).

On the NFS server side, the server has no way of knowing whether or
not "root" was issuing the write.  The NFS server could know whether
or not the "root squash" flag is set, and pass that to ext4, but
that's not currently being done.

						- Ted
