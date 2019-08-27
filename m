Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF3549F047
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfH0Qft (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 12:35:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50988 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726678AbfH0Qft (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Aug 2019 12:35:49 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7RGZBvV019304
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Aug 2019 12:35:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 41CEA42049E; Tue, 27 Aug 2019 12:35:11 -0400 (EDT)
Date:   Tue, 27 Aug 2019 12:35:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harald Dunkel <harald.dunkel@aixigo.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org
Subject: Re: fsck on ext4: "WARN Wrong bounce buffer write length: 1024 != 0"
Message-ID: <20190827163511.GM28066@mit.edu>
References: <22367f07-3448-f771-0363-b5c6f500b77d@aixigo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22367f07-3448-f771-0363-b5c6f500b77d@aixigo.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 27, 2019 at 08:00:14AM +0200, Harald Dunkel wrote:
> FYI: "fsck -y" on an external USB drive (USB-C, ext4) gave
> me a ton of messages
> 
> :
> [  191.261939] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
> [  191.263743] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
> [  191.263788] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
> [  191.263840] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
> [  191.266857] xhci_hcd 0000:05:00.0: WARN Wrong bounce buffer write length: 1024 != 0
> :
> 
> Related to 597c56e372dab2c7f79b8d700aad3a5deebf9d1b, AFAICT.
> 
> Kernel is 4.19.67-1 (Debian proposed-updates).

+mathias.nyman@intel.com, linux-usb@vger.kernel.org
linux-ext4 to BCC

That's a USB XHCI issue, not an ext4 issue.  I'm handing this to the
XHCI maintainer and the Linux USB mailing list.

Cheers,

						- Ted
