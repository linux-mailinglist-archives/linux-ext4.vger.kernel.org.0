Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 308AF9C0EA
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Aug 2019 01:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfHXXJi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Aug 2019 19:09:38 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48341 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727950AbfHXXJi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Aug 2019 19:09:38 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7ON9UHx008124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Aug 2019 19:09:31 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 267C242049E; Sat, 24 Aug 2019 19:09:30 -0400 (EDT)
Date:   Sat, 24 Aug 2019 19:09:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ayush Ranjan <ayushr2@illinois.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Ext4 documentation fixes.
Message-ID: <20190824230930.GB5163@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        Andreas Dilger <adilger@dilger.ca>,
        Ayush Ranjan <ayushr2@illinois.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+UE=SPyMXZUhHFm0KgvihPdaE=yH5ra6n1C4XhKgM6aGheo=A@mail.gmail.com>
 <DEDD6BA5-6E18-4ED6-9EF6-E11EDA593700@dilger.ca>
 <20190824152453.03737143@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824152453.03737143@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 24, 2019 at 03:24:53PM -0600, Jonathan Corbet wrote:
> I've applied this to the docs tree.
> 
> However, Ayush: the patch was rather badly corrupted by your mail client.
> I managed to fix it up, but please in the future verify that you can email
> a patch to yourself and apply it before submitting it.  There may be some
> useful hints in Documentation/process/email-clients.rst .

Hi Jon,

If you haven't pushed out your doc tree, can you please drop it?  I've
already applied an (improved) version of this patch to the ext4 tree,
and I actually have some plans to do further fixups of ext4 on-disk
format documentation in the ext4 tree.  So it would be easier if we
keep ext4 documentation updates in the ext4 git tree.

Thanks,

					- Ted
