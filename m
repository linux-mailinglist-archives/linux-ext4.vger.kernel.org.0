Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A886120CC
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2019 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfEBRDs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 May 2019 13:03:48 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41632 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbfEBRDs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 May 2019 13:03:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 18F0227E9A0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Change feature name from fname_encoding to casefold?
Organization: Collabora
References: <20190413054317.7388-1-krisman@collabora.com>
        <20190413054317.7388-9-krisman@collabora.com>
        <20190502162527.GC25007@mit.edu>
Date:   Thu, 02 May 2019 13:03:42 -0400
In-Reply-To: <20190502162527.GC25007@mit.edu> (Theodore Ts'o's message of
        "Thu, 2 May 2019 12:25:27 -0400")
Message-ID: <85woj8kcup.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> Given how we've simplified how we handle Unicode --- in particular,
> not doing any kind of normalization unless we are doing case-folding
> compares, I think it will be more user-friendly if we rename the
> feature from fname_encoding to casefold.
>
> What do you think?  Any objections?

I don't object at all, but I'll need to update some test
packages/documentation already published to customers in order to change
it. So I'd need a final decision to be taken quickly on it. :)

-- 
Gabriel Krisman Bertazi
