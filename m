Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1203911EA9D
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 19:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfLMSp4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 13:45:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57194 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728603AbfLMSp4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Dec 2019 13:45:56 -0500
Received: from callcc.thunk.org (guestnat-104-132-34-105.corp.google.com [104.132.34.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBDIjqTK015538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Dec 2019 13:45:53 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 293B6420E60; Fri, 13 Dec 2019 13:45:52 -0500 (EST)
Date:   Fri, 13 Dec 2019 13:45:52 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH -v3] ext4: simulate various I/O and checksum errors when
 reading metadata
Message-ID: <20191213184552.GB273569@mit.edu>
References: <8504AF0E-39F8-4C56-86EE-9945E15C1A16@dilger.ca>
 <20191209012317.59398-1-tytso@mit.edu>
 <14336F5B-D8D2-4B73-A60C-3B63997F0827@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14336F5B-D8D2-4B73-A60C-3B63997F0827@dilger.ca>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 08, 2019 at 09:14:08PM -0700, Andreas Dilger wrote:
> 
> This should be marked unlikely(), as it is definitely one of the places
> that is legitimately rarely true.  Sorry for not pointing this out on
> the previous version of the patch.

Good point; thanks, I've made that change.

					- Ted
