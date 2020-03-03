Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC84D177D7A
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2020 18:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgCCRas (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Mar 2020 12:30:48 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43333 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726899AbgCCRas (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Mar 2020 12:30:48 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 023HUcGc014351
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Mar 2020 12:30:42 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7BAD442045B; Tue,  3 Mar 2020 12:30:38 -0500 (EST)
Date:   Tue, 3 Mar 2020 12:30:38 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Bo Branten <bosse@acc.umu.se>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: A question on umounting without flushing journal
Message-ID: <20200303173038.GC61444@mit.edu>
References: <alpine.DEB.2.21.2003031120390.949380@stalin.acc.umu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003031120390.949380@stalin.acc.umu.se>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 03, 2020 at 11:26:13AM +0100, Bo Branten wrote:
> 
> now I have another question on how to test the ext4 driver we implement for
> another os: At mount time the driver should check the journal and use jbd2
> to replay if there is anything left in it and I would like to ask if there
> is any other methods to do an unclean umount in linux besides pressing
> reset? I would like to leave a lot of records in the journal that our driver
> can try to process?

The standard way to do this in xfstests is using the dm-flakey
device-mapper device.  We set it up so that all reads and writes are
passed through, and then we start some workload such as fsstress, and
then we reconfigure dm-flakey to drop 100% of all write requests to
the underlying block device.

We then kill the workload, and unmount the file system, and then we
reset the dm-flakey device to pass through 100% of all writes.  This
simulates quite accurately what the block device would look like after
a sudden power failure, but it doesn't require a power-fail rack
(without shortening the lives of the equipment; dropping power tends
to put a lot stress on the hardware).

Cheers,

					- Ted
