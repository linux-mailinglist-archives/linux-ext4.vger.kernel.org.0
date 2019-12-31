Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA9212D5FF
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Dec 2019 04:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfLaDp3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Dec 2019 22:45:29 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36439 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbfLaDp3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 30 Dec 2019 22:45:29 -0500
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBV3jL2i007479
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Dec 2019 22:45:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 592A9420485; Mon, 30 Dec 2019 22:45:21 -0500 (EST)
Date:   Mon, 30 Dec 2019 22:45:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Benno Schulenberg <bensberg@telfort.nl>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] e2image: remove redundant -fr from man page and usage
 message
Message-ID: <20191231034521.GE3669@mit.edu>
References: <20191205175735.28054-1-bensberg@telfort.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205175735.28054-1-bensberg@telfort.nl>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 05, 2019 at 06:57:35PM +0100, Benno Schulenberg wrote:
> Also, add a missing dash and two missing brackets and two missing
> spaces, and remove three excess spaces.
> 
> Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>

Thanks, applied.

					- Ted
