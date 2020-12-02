Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4711C2CC2CD
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 17:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgLBQzZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 11:55:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33959 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728348AbgLBQzY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 11:55:24 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B2Gs8hR002586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Dec 2020 11:54:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 33864420136; Wed,  2 Dec 2020 11:54:08 -0500 (EST)
Date:   Wed, 2 Dec 2020 11:54:08 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 03/15] e2fsck: port fc changes from kernel's recovery.c
 to e2fsck
Message-ID: <20201202165408.GG390058@mit.edu>
References: <20201120191606.2224881-1-harshadshirwadkar@gmail.com>
 <20201120191606.2224881-4-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120191606.2224881-4-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 11:15:54AM -0800, Harshad Shirwadkar wrote:
> This patch makes recovery.c identical with fast commit kernel changes.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good,

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

