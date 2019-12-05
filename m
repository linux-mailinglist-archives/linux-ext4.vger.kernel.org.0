Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6C7114400
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Dec 2019 16:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbfLEPsf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Dec 2019 10:48:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33486 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbfLEPsf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Dec 2019 10:48:35 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xB5FmRqt012370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Dec 2019 10:48:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 530F2421A48; Thu,  5 Dec 2019 10:48:27 -0500 (EST)
Date:   Thu, 5 Dec 2019 10:48:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Viliam Lejcik <Viliam.Lejcik@kistler.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: e2fsprogs: setting UUID with tune2fs corrupts an ext4 fs image
Message-ID: <20191205154827.GA35599@mit.edu>
References: <5fd4546cdc7f43f282716afb1e1a18cb@kistler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd4546cdc7f43f282716afb1e1a18cb@kistler.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 05, 2019 at 12:36:35PM +0000, Viliam Lejcik wrote:
> 
> This behavior can be reproduced on an ext4 fs image, so there's no need to run it on the device.

Where can we download or otherwise obtain the image where you are
seeing the problem?

Thanks,

					- Ted
