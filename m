Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F68D168B08
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Feb 2020 01:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBVAeF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 19:34:05 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57123 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726735AbgBVAeF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 19:34:05 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01M0XsLL016203
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 19:33:56 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4BDFA4211EF; Fri, 21 Feb 2020 19:33:54 -0500 (EST)
Date:   Fri, 21 Feb 2020 19:33:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jitindar SIngh, Suraj" <surajjs@amazon.com>
Cc:     "cai@lca.pw" <cai@lca.pw>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "paulmck@kernel.org" <paulmck@kernel.org>
Subject: Re: null-ptr-deref due to "ext4: fix potential race between online
 resizing and write operations"
Message-ID: <20200222003354.GB873427@mit.edu>
References: <1582293736.7365.109.camel@lca.pw>
 <d6ca935e3c70f275ec669fae8984b11f383baa1f.camel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6ca935e3c70f275ec669fae8984b11f383baa1f.camel@amazon.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 21, 2020 at 07:58:01PM +0000, Jitindar SIngh, Suraj wrote:
> On Fri, 2020-02-21 at 09:02 -0500, Qian Cai wrote:
> > Reverted the linux-next commit c20bac9bf82c ("ext4: fix potential
> > race between
> > s_flex_groups online resizing and access") fixed the crash below
> > (with line
> > numbers),
> 
> Good catch, this is a bug where the dereference of the array
> s_flex_groups needs to happen after the "if (flex_size > 1)" if
> statement in fs/ext4/ialloc.c:373

Cai, thanks for noting the problem!  Suraj, I've fixed up the patch on
the ext4.git tree.

						- Ted
