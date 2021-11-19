Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065EE4569DB
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Nov 2021 06:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhKSFvl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Nov 2021 00:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhKSFvl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Nov 2021 00:51:41 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD34C061574
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 21:48:40 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id a15so6138525ilj.8
        for <linux-ext4@vger.kernel.org>; Thu, 18 Nov 2021 21:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2UaBAPk9+dX1nyaB3MzZPqLop0ttm08MjzVxvsPoZA=;
        b=UDyTUk11/a32o2RNnkegM+/PGeKx0rK+ZiY4hQ1KmX5J/NBWSK/ixBAe+8Op5lG3/m
         LWn0GK6/75QAo6QYXIZlF7HNwgE2gbXFwEJFfaL7f1zcntzCn44nYa6f/eKIWEfcmzSI
         F7XdOSzMZSl+cPTAkfW+38ia8PXRI6j8VoS4l4tLzMLHxWbXtOoytRIkFNyj2qFVMGUX
         9mg+haQO09LNcvDHvHZaNWYT8cVGJG6w3mfCbepCEPxYzVClHyLUV5Sq1e0+80akYkh5
         msyRyFk7vJ43a775F+9RCbg0WgrMJoafoBWwYPSl7cS0aYmHbU7eEp+ZEBe1dNH+8ggO
         xJpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2UaBAPk9+dX1nyaB3MzZPqLop0ttm08MjzVxvsPoZA=;
        b=emCsrWjvCJck4sP0FGI/8HKd/J/DK/xThhgUKoM3HDVU8HpZRd/SlkoLXKdpJW34hY
         DDyUElrV4BvQomSKlhyNCJGMnkyKY+eXAyXLHpCkf3R386AvJr6TG5HOTrwlH0GCjpRc
         R6+knfL8bUwFbehh4208xWpUesD2zl+WpqUSp0GP1TDDbV/xzlI0iO7ttJ79sgJWAHoj
         YVyOI0nM+cjLXqjTwI3LgsKFQDyM+e18mwjWfuMJOEdxvls1rcHB+EB+6bmmjdmpPsXm
         1opH60ZtRPM+FUHmlRl2/A6aZPkrIVVxbFvMWs3xhnGsJYy7CtmTg+7lrGqN3g8Bi5O9
         i9og==
X-Gm-Message-State: AOAM533QjgZPhqXgB/DaiQFLluzZLdK6RokHZi26bEc0CH80YJJ+Cpqi
        +1OZ/8oSomLYvlUNSHEHRIwmuC8cwImhWXoDFr8=
X-Google-Smtp-Source: ABdhPJw5DB8Y5GvFIbCY2VAUIdCUWYCzlqHFJthiqOrHqHNRz3pUwlq8nhvrhLT0/dgiYnXDQrcBtATNXhegN6UflvI=
X-Received: by 2002:a05:6e02:1ba6:: with SMTP id n6mr3196265ili.254.1637300919715;
 Thu, 18 Nov 2021 21:48:39 -0800 (PST)
MIME-Version: 1.0
References: <20211118235744.802584-1-krisman@collabora.com>
In-Reply-To: <20211118235744.802584-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Nov 2021 07:48:29 +0200
Message-ID: <CAOQ4uxhbDgdZZ0qphWg1vnW4ZoAkUxcQp631yZO8W49AE18W9g@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Petr Vorel <pvorel@suse.cz>, Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 19, 2021 at 1:57 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> FAN_FS_ERROR was merged into Linus tree, and the PIDFD testcases reached
> LTP.  Therefore, I'm sending a new version of the FAN_FS_ERROR LTP
> tests.  This is the v4 of this patchset, and it applies the feedback of
> the previous version.
>
> Thanks,
>
> ---
>
> Original cover letter:
>
> FAN_FS_ERROR is a new (still unmerged) fanotify event to monitor
> fileystem errors.  This patchset introduces a new LTP test for this
> feature.
>
> Testing file system errors is slightly tricky, in particular because
> they are mostly file system dependent.  Since there are only patches for
> ext4, I choose to make the test around it, since there wouldn't be much
> to do with other file systems.  The second challenge is how we cause the
> file system errors, since there is no error injection for ext4 in Linux.
> In this series, this is done by corrupting specific data in the
> test device with the help of debugfs.
>
> The FAN_FS_ERROR feature is flying around linux-ext4 and fsdevel, and
> the latest version is available on the branch below:
>
>     https://gitlab.collabora.com/krisman/linux -b fanotify-notifications-v9
>
> A proper manpage description is also available on the respective mailing
> list, or in the branch below:
>
>     https://gitlab.collabora.com/krisman/man-pages.git -b fan-fs-error
>
> Please, let me know your thoughts.
>

Gabriel,

Can you please push these v4 patches to your gitlab tree?

Thanks,
Amir.
