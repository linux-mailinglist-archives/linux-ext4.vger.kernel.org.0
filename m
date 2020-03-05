Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CCC817AFD4
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 21:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgCEUgR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 15:36:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43385 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725991AbgCEUgQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 15:36:16 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 025KaBPC032321
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 15:36:11 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C7DF642045B; Thu,  5 Mar 2020 15:36:10 -0500 (EST)
Date:   Thu, 5 Mar 2020 15:36:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: force buffer up-to-date while marking it dirty
Message-ID: <20200305203610.GB20967@mit.edu>
References: <20191224190940.157952-1-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224190940.157952-1-harshadshirwadkar@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 24, 2019 at 11:09:40AM -0800, Harshad Shirwadkar wrote:
> Writeback errors can leave buffer in not up-to-date state when there
> are errors during background writes. Force buffer up-to-date while
> marking it dirty.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

					- Ted
