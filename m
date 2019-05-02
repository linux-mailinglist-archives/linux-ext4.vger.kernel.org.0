Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F108212015
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2019 18:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEBQZe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 May 2019 12:25:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57793 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726381AbfEBQZe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 May 2019 12:25:34 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x42GPRZB027151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 2 May 2019 12:25:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 76992420024; Thu,  2 May 2019 12:25:27 -0400 (EDT)
Date:   Thu, 2 May 2019 12:25:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Change feature name from fname_encoding to casefold?
Message-ID: <20190502162527.GC25007@mit.edu>
References: <20190413054317.7388-1-krisman@collabora.com>
 <20190413054317.7388-9-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190413054317.7388-9-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Given how we've simplified how we handle Unicode --- in particular,
not doing any kind of normalization unless we are doing case-folding
compares, I think it will be more user-friendly if we rename the
feature from fname_encoding to casefold.

What do you think?  Any objections?

					- Ted
