Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 277B31DD42C
	for <lists+linux-ext4@lfdr.de>; Thu, 21 May 2020 19:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgEURUm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 May 2020 13:20:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35166 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728796AbgEURUm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 May 2020 13:20:42 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04LHKZtw016256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 May 2020 13:20:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1607F420304; Thu, 21 May 2020 13:20:35 -0400 (EDT)
Date:   Thu, 21 May 2020 13:20:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jonny Grant <jg@jguk.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] /fs/ext4/ext4.h add a comment to ext4_dir_entry_2
Message-ID: <20200521172035.GB2946569@mit.edu>
References: <5b9bc322-fe02-72cc-9aa7-a27b26894ce0@jguk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b9bc322-fe02-72cc-9aa7-a27b26894ce0@jguk.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 08, 2020 at 09:36:43PM +0100, Jonny Grant wrote:
> Please find attached patch for review.
> 
> 2020-05-08  Jonny Grant  <jg@jguk.org>
> 
> 	tests: comment ext4_dir_entry_2 file_type member
> 
> Cheers, Jonny

Hi Johnny, could you resubmit with the Signed-off-By: line?  That's
really important.  If you don't understand why, please read:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin       

Cheers,

						- Ted
