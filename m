Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6061244C
	for <lists+linux-ext4@lfdr.de>; Thu,  2 May 2019 23:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbfEBVqk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 May 2019 17:46:40 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42640 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBVqk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 May 2019 17:46:40 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 91A0F26117F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: Change feature name from fname_encoding to casefold?
Organization: Collabora
References: <20190413054317.7388-1-krisman@collabora.com>
        <20190413054317.7388-9-krisman@collabora.com>
        <20190502162527.GC25007@mit.edu> <20190502205056.GA5193@magnolia>
Date:   Thu, 02 May 2019 17:46:33 -0400
In-Reply-To: <20190502205056.GA5193@magnolia> (Darrick J. Wong's message of
        "Thu, 2 May 2019 13:50:56 -0700")
Message-ID: <85d0l0jzra.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

"Darrick J. Wong" <darrick.wong@oracle.com> writes:

> On Thu, May 02, 2019 at 12:25:27PM -0400, Theodore Ts'o wrote:
>> Given how we've simplified how we handle Unicode --- in particular,
>> not doing any kind of normalization unless we are doing case-folding
>> compares, I think it will be more user-friendly if we rename the
>> feature from fname_encoding to casefold.
>
> TBH /me hadn't done enough reviewing even to notice the feature was
> named 'fname_encoding' (whatever that means -- encoded how?).
> IMHO 'casefold' is more descriptive about what the feature provides
> (folding case for directory name comparisons, right?)
>

This name was accurate until the v6 of the patches.  In v7, we decided
to no longer apply file name encoding normalization system-wide during
lookups, which changed the semantics of this feature flag.  By that
time, though, the name was already committed to e2fsprogs, so i didn't
bother to change it.

-- 
Gabriel Krisman Bertazi
