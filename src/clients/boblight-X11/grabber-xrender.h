/*
 * boblight
 * Copyright (C) Bob  2009 
 * 
 * boblight is free software: you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * boblight is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 * See the GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License along
 * with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef GRABBERXRENDER
#define GRABBERXRENDER

#include "grabber-base.h"

#include <X11/extensions/Xrender.h>

class CGrabberXRender : public CGrabber
{
  public:
    CGrabberXRender(void* boblight);
    ~CGrabberXRender();
    
    bool ExtendedSetup();
    bool Run(volatile bool& stop);

  private:

    bool CheckExtensions();
    
    XRenderPictFormat*       m_srcformat;
    XRenderPictFormat*       m_dstformat;
    Picture                  m_srcpicture;
    Picture                  m_dstpicture;
    XRenderPictureAttributes m_pictattr;
    XTransform               m_transform;
    Pixmap                   m_pixmap;
};

#endif //GRABBERXRENDER