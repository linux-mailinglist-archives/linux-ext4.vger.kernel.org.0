Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6B01C11E9
	for <lists+linux-ext4@lfdr.de>; Fri,  1 May 2020 14:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgEAMKZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 May 2020 08:10:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgEAMKZ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 1 May 2020 08:10:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C15521582;
        Fri,  1 May 2020 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588335024;
        bh=f4S0IQ7bZ5MS08fosU8ISHJYsrPRMpM6z88jS+5LdwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H5h9+cfbPftSagI3TrtRp4/M0sGhavZGn3jOw1jJoXr88Wh+sKTKAffkpni8Z+mhl
         qVpgiX130VCH/GFUp6/lvb7lBlCPYarb8HBTEv18qnx0/En6xL2F52P/6FFN4i5JRJ
         5RICwlxVYRB/AOH9RRlQ0lwT/XRhVRqSzq7dsGUs=
Date:   Fri, 1 May 2020 14:10:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ashwin H <ashwinh@vmware.com>
Cc:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@kernel.org" <stable@kernel.org>,
        Srivatsa Bhat <srivatsab@vmware.com>,
        "srivatsa@csail.mit.edu" <srivatsa@csail.mit.edu>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Steven Rostedt <srostedt@vmware.com>,
        "ashwin.hiranniah@gmail.com" <ashwin.hiranniah@gmail.com>
Subject: Re: [PATCH 0/5] Backport to 4.9- ext4: protect journal inode's
 blocks using block_validity
Message-ID: <20200501121008.GA1613024@kroah.com>
References: <cover.1587713792.git.ashwinh@vmware.com>
 <20200429125909.GA2124190@kroah.com>
 <A37B50A5-C978-47A6-9861-048AEA9788EE@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A37B50A5-C978-47A6-9861-048AEA9788EE@vmware.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 29, 2020 at 08:39:45PM +0000, Ashwin H wrote:
> I have sent patches for 4.14 tree

Thank you, all of these are now queued up.

greg k-h
